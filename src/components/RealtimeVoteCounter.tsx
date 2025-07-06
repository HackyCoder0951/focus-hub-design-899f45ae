import React, { useEffect, useState } from 'react';
import { Button } from './ui/button';
import { ThumbsUp, ThumbsDown } from 'lucide-react';
import { useRealtime } from '../hooks/useRealtime';
import { supabase } from '../integrations/supabase/client';
import { useAuth } from '../contexts/AuthContext';

interface VoteCounterProps {
  targetType: 'question' | 'answer';
  targetId: number;
  initialVoteCount?: number;
  initialVoteScore?: number;
  onVoteChange?: (voteValue: number) => void;
}

export const RealtimeVoteCounter: React.FC<VoteCounterProps> = ({
  targetType,
  targetId,
  initialVoteCount = 0,
  initialVoteScore = 0,
  onVoteChange
}) => {
  const [voteCount, setVoteCount] = useState(initialVoteCount);
  const [voteScore, setVoteScore] = useState(initialVoteScore);
  const [userVote, setUserVote] = useState<number | null>(null);
  const [isVoting, setIsVoting] = useState(false);
  const { user } = useAuth();

  // Fetch initial vote data
  const fetchVoteData = async () => {
    try {
      const { data, error } = await supabase
        .rpc('get_vote_counts', { 
          target_type: targetType, 
          target_id: targetId 
        });
      
      if (error) throw error;
      
      if (data && data.length > 0) {
        setVoteCount(data[0].vote_count || 0);
        setVoteScore(data[0].vote_score || 0);
      }
    } catch (error) {
      console.error('Error fetching vote data:', error);
    }
  };

  // Fetch user's vote
  const fetchUserVote = async () => {
    if (!user) return;
    
    try {
      const tableName = targetType === 'question' ? 'question_votes' : 'answer_votes';
      const idField = targetType === 'question' ? 'question_id' : 'answer_id';
      
      const { data, error } = await supabase
        .from(tableName)
        .select('vote_value')
        .eq(idField, targetId)
        .eq('user_id', user.id)
        .single();
      
      if (error && error.code !== 'PGRST116') throw error; // PGRST116 = no rows returned
      
      setUserVote(data?.vote_value || null);
    } catch (error) {
      console.error('Error fetching user vote:', error);
    }
  };

  // Handle vote submission
  const handleVote = async (voteValue: number) => {
    if (!user || isVoting) return;
    
    setIsVoting(true);
    
    try {
      const tableName = targetType === 'question' ? 'question_votes' : 'answer_votes';
      const idField = targetType === 'question' ? 'question_id' : 'answer_id';
      
      if (userVote === voteValue) {
        // Remove vote
        const { error } = await supabase
          .from(tableName)
          .delete()
          .eq(idField, targetId)
          .eq('user_id', user.id);
        
        if (error) throw error;
        setUserVote(null);
        onVoteChange?.(0);
      } else {
        // Upsert vote
        const { error } = await supabase
          .from(tableName)
          .upsert({
            [idField]: targetId,
            user_id: user.id,
            vote_value: voteValue
          });
        
        if (error) throw error;
        setUserVote(voteValue);
        onVoteChange?.(voteValue);
      }
    } catch (error) {
      console.error('Error submitting vote:', error);
    } finally {
      setIsVoting(false);
    }
  };

  // Handle real-time vote updates
  const handleVoteUpdate = (update: any) => {
    if (update.target_type === targetType && update.target_id === targetId) {
      // Update vote counts (these will be calculated by the database trigger)
      fetchVoteData();
    }
  };

  // Set up real-time subscription
  useRealtime({
    onVoteUpdate: handleVoteUpdate
  });

  useEffect(() => {
    fetchVoteData();
    fetchUserVote();
  }, [targetType, targetId, user]);

  return (
    <div className="flex items-center gap-2">
      <Button
        variant={userVote === 1 ? "default" : "outline"}
        size="sm"
        onClick={() => handleVote(1)}
        disabled={isVoting || !user}
        className="flex items-center gap-1"
      >
        <ThumbsUp className="h-4 w-4" />
        <span className="text-sm font-medium">
          {voteScore > 0 ? `+${voteScore}` : voteScore}
        </span>
      </Button>
      
      <Button
        variant={userVote === -1 ? "default" : "outline"}
        size="sm"
        onClick={() => handleVote(-1)}
        disabled={isVoting || !user}
        className="flex items-center gap-1"
      >
        <ThumbsDown className="h-4 w-4" />
      </Button>
      
      <span className="text-sm text-gray-500">
        {voteCount} vote{voteCount !== 1 ? 's' : ''}
      </span>
    </div>
  );
}; 