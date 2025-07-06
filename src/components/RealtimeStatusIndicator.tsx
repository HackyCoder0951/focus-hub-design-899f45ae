import React from 'react';
import { Badge } from './ui/badge';
import { Wifi, WifiOff } from 'lucide-react';
import { useRealtime } from '../hooks/useRealtime';

interface RealtimeStatusIndicatorProps {
  showDetails?: boolean;
}

export const RealtimeStatusIndicator: React.FC<RealtimeStatusIndicatorProps> = ({
  showDetails = false
}) => {
  const { isConnected } = useRealtime();

  return (
    <div className="flex items-center gap-2">
      {isConnected ? (
        <>
          <Wifi className="h-4 w-4 text-green-500" />
          <Badge variant="outline" className="text-green-600 border-green-600">
            Live
          </Badge>
          {showDetails && (
            <span className="text-xs text-green-600">
              Real-time updates active
            </span>
          )}
        </>
      ) : (
        <>
          <WifiOff className="h-4 w-4 text-red-500" />
          <Badge variant="outline" className="text-red-600 border-red-600">
            Offline
          </Badge>
          {showDetails && (
            <span className="text-xs text-red-600">
              Real-time updates disconnected
            </span>
          )}
        </>
      )}
    </div>
  );
}; 