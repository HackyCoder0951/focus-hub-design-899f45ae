# Real-time Features Implementation

This document explains how to implement and use real-time features in your Q&A application using Supabase Realtime.

## 🚀 Overview

The real-time system provides:
- **Live notifications** for new answers, comments, and votes
- **Real-time vote counts** that update instantly
- **Live comment updates** as users interact
- **Connection status indicators** to show real-time state

## 📋 Database Setup

### 1. Run the Real-time Migration

```bash
# Apply the real-time migration
supabase db push
```

This migration includes:
- Database functions for broadcasting updates
- Triggers for automatic real-time notifications
- RLS policies for real-time access
- Helper functions for vote counts and notifications

### 2. Enable Realtime for Tables

The migration automatically enables realtime for:
- `questions`
- `answers` 
- `question_votes`
- `answer_votes`
- `answer_comments`
- `question_notifications`
- `answer_notifications`

## 🔧 Frontend Implementation

### 1. Install Dependencies

```bash
npm install @supabase/supabase-js
```

### 2. Use the Real-time Hook

```tsx
import { useRealtime } from '../hooks/useRealtime';

function MyComponent() {
  const { isConnected } = useRealtime({
    userId: user?.id,
    onVoteUpdate: (update) => {
      console.log('Vote updated:', update);
    },
    onCommentUpdate: (update) => {
      console.log('Comment updated:', update);
    },
    onNotificationUpdate: (update) => {
      console.log('Notification updated:', update);
    }
  });

  return (
    <div>
      <p>Connection status: {isConnected ? 'Connected' : 'Disconnected'}</p>
    </div>
  );
}
```

### 3. Real-time Components

#### RealtimeNotificationBadge

Shows live notification counts with real-time updates:

```tsx
import { RealtimeNotificationBadge } from '../components/RealtimeNotificationBadge';

function Header() {
  return (
    <header>
      <RealtimeNotificationBadge />
    </header>
  );
}
```

#### RealtimeStatusIndicator

Shows connection status for real-time features:

```tsx
import { RealtimeStatusIndicator } from '../components/RealtimeStatusIndicator';

function StatusBar() {
  return (
    <div className="status-bar">
      <RealtimeStatusIndicator showDetails={true} />
    </div>
  );
}
```

## 📡 Real-time Events

### Vote Updates

When users vote on questions or answers:

```typescript
interface VoteUpdate {
  target_type: 'question' | 'answer';
  target_id: number;
  vote_count: number;
  vote_score: number;
  user_id: string;
  vote_value: number;
}
```

### Comment Updates

When comments are added, updated, or deleted:

```typescript
interface CommentUpdate {
  id: number;
  answer_id: number;
  user_id: string;
  body: string;
  parent_comment_id?: number;
  created_at: string;
  action: 'INSERT' | 'UPDATE' | 'DELETE';
}
```

### Notification Updates

When new notifications are created:

```typescript
interface NotificationUpdate {
  id: number;
  user_id: string;
  notification_type: string;
  message: string;
  is_read: boolean;
  related_id?: number;
  created_at: string;
  action: 'INSERT' | 'UPDATE' | 'DELETE';
}
```

## 🎯 Usage Examples

### 1. Real-time Vote Counter

```tsx
function QuestionCard({ question }) {
  const [voteCount, setVoteCount] = useState(question.vote_count);
  
  useRealtime({
    onVoteUpdate: (update) => {
      if (update.target_type === 'question' && update.target_id === question.id) {
        setVoteCount(update.vote_count);
      }
    }
  });

  return (
    <div>
      <h3>{question.title}</h3>
      <p>Votes: {voteCount}</p>
    </div>
  );
}
```

### 2. Live Notifications

```tsx
function NotificationCenter() {
  const [notifications, setNotifications] = useState([]);
  
  useRealtime({
    userId: user?.id,
    onNotificationUpdate: (update) => {
      if (update.action === 'INSERT') {
        setNotifications(prev => [update, ...prev]);
      }
    }
  });

  return (
    <div>
      {notifications.map(notification => (
        <div key={notification.id}>
          {notification.message}
        </div>
      ))}
    </div>
  );
}
```

### 3. Real-time Comments

```tsx
function AnswerComments({ answerId }) {
  const [comments, setComments] = useState([]);
  
  useRealtime({
    onCommentUpdate: (update) => {
      if (update.answer_id === answerId) {
        if (update.action === 'INSERT') {
          setComments(prev => [...prev, update]);
        }
      }
    }
  });

  return (
    <div>
      {comments.map(comment => (
        <div key={comment.id}>
          {comment.body}
        </div>
      ))}
    </div>
  );
}
```

## 🔒 Security Considerations

### RLS Policies

The real-time system respects Row Level Security:
- Users can only see their own notifications
- Vote updates are filtered by user permissions
- Comment updates respect answer ownership

### Rate Limiting

Consider implementing rate limiting for:
- Vote submissions (prevent spam)
- Comment posting (prevent flooding)
- Notification creation (prevent abuse)

## 🚨 Troubleshooting

### Connection Issues

1. **Check Supabase URL and Key**
   ```typescript
   const supabase = createClient(
     process.env.REACT_APP_SUPABASE_URL!,
     process.env.REACT_APP_SUPABASE_ANON_KEY!
   );
   ```

2. **Verify Realtime is Enabled**
   ```sql
   -- Check if realtime is enabled for tables
   SELECT * FROM pg_publication_tables 
   WHERE pubname = 'supabase_realtime';
   ```

3. **Check Network Connectivity**
   - Ensure WebSocket connections are allowed
   - Check firewall settings
   - Verify SSL certificates

### Performance Issues

1. **Limit Subscription Scope**
   ```typescript
   // Only subscribe to relevant data
   useRealtime({
     userId: user?.id, // Filter by user
     onVoteUpdate: (update) => {
       // Only handle relevant updates
       if (update.target_id === currentQuestionId) {
         // Handle update
       }
     }
   });
   ```

2. **Clean Up Subscriptions**
   ```typescript
   useEffect(() => {
     const { unsubscribeAll } = useRealtime({...});
     
     return () => {
       unsubscribeAll();
     };
   }, []);
   ```

## 📊 Monitoring

### Connection Status

Monitor real-time connection status:

```typescript
const { isConnected } = useRealtime({});

// Log connection changes
useEffect(() => {
  console.log('Real-time connection:', isConnected);
}, [isConnected]);
```

### Error Handling

```typescript
useRealtime({
  onVoteUpdate: (update) => {
    try {
      // Handle update
    } catch (error) {
      console.error('Error handling vote update:', error);
    }
  }
});
```

## 🔄 Best Practices

1. **Optimistic Updates**: Update UI immediately, then sync with server
2. **Debounce Updates**: Prevent excessive re-renders
3. **Error Recovery**: Implement retry logic for failed connections
4. **User Feedback**: Show connection status to users
5. **Graceful Degradation**: Work offline when possible

## 🎉 Next Steps

1. **Implement the components** in your Q&A pages
2. **Add real-time indicators** to show live status
3. **Test with multiple users** to verify real-time updates
4. **Monitor performance** and optimize as needed
5. **Add more real-time features** like typing indicators, presence

The real-time system is now ready to provide a dynamic, engaging user experience for your Q&A application! 