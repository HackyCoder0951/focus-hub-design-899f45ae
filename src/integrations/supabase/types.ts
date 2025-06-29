export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string
          email: string
          full_name: string | null
          avatar_url: string | null
          bio: string | null
          location: string | null
          website: string | null
          settings: Json | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id: string
          email: string
          full_name?: string | null
          avatar_url?: string | null
          bio?: string | null
          location?: string | null
          website?: string | null
          settings?: Json | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          email?: string
          full_name?: string | null
          avatar_url?: string | null
          bio?: string | null
          location?: string | null
          website?: string | null
          settings?: Json | null
          created_at?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "profiles_id_fkey"
            columns: ["id"]
            isOneToOne: true
            referencedRelation: "users"
            referencedColumns: ["id"]
          }
        ]
      }
      user_roles: {
        Row: {
          id: string
          user_id: string
          role: Database["public"]["Enums"]["app_role"]
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          role?: Database["public"]["Enums"]["app_role"]
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          role?: Database["public"]["Enums"]["app_role"]
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "user_roles_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          }
        ]
      }
      posts: {
        Row: {
          id: string
          user_id: string | null
          content: string
          media_url: string | null
          created_at: string
          updated_at: string
          is_deleted: boolean
        }
        Insert: {
          id?: string
          user_id?: string | null
          content: string
          media_url?: string | null
          created_at?: string
          updated_at?: string
          is_deleted?: boolean
        }
        Update: {
          id?: string
          user_id?: string | null
          content?: string
          media_url?: string | null
          created_at?: string
          updated_at?: string
          is_deleted?: boolean
        }
        Relationships: [
          {
            foreignKeyName: "posts_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          }
        ]
      }
      likes: {
        Row: {
          id: string
          user_id: string | null
          post_id: string | null
          created_at: string
        }
        Insert: {
          id?: string
          user_id?: string | null
          post_id?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string | null
          post_id?: string | null
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "likes_post_id_fkey"
            columns: ["post_id"]
            isOneToOne: false
            referencedRelation: "posts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "likes_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          }
        ]
      }
      followers: {
        Row: {
          id: string
          follower_id: string | null
          following_id: string | null
          created_at: string
        }
        Insert: {
          id?: string
          follower_id?: string | null
          following_id?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          follower_id?: string | null
          following_id?: string | null
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "followers_follower_id_fkey"
            columns: ["follower_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "followers_following_id_fkey"
            columns: ["following_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          }
        ]
      }
      notifications: {
        Row: {
          id: string
          user_id: string | null
          type: string
          data: Json | null
          is_read: boolean
          created_at: string
        }
        Insert: {
          id?: string
          user_id?: string | null
          type: string
          data?: Json | null
          is_read?: boolean
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string | null
          type?: string
          data?: Json | null
          is_read?: boolean
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "notifications_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          }
        ]
      }
      chats: {
        Row: {
          id: string
          is_group: boolean
          name: string | null
          created_at: string
        }
        Insert: {
          id?: string
          is_group?: boolean
          name?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          is_group?: boolean
          name?: string | null
          created_at?: string
        }
        Relationships: []
      }
      chat_members: {
        Row: {
          id: string
          chat_id: string | null
          user_id: string | null
          joined_at: string
        }
        Insert: {
          id?: string
          chat_id?: string | null
          user_id?: string | null
          joined_at?: string
        }
        Update: {
          id?: string
          chat_id?: string | null
          user_id?: string | null
          joined_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "chat_members_chat_id_fkey"
            columns: ["chat_id"]
            isOneToOne: false
            referencedRelation: "chats"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "chat_members_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          }
        ]
      }
      chat_messages: {
        Row: {
          id: string
          chat_id: string | null
          user_id: string | null
          content: string | null
          media_url: string | null
          created_at: string
        }
        Insert: {
          id?: string
          chat_id?: string | null
          user_id?: string | null
          content?: string | null
          media_url?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          chat_id?: string | null
          user_id?: string | null
          content?: string | null
          media_url?: string | null
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "chat_messages_chat_id_fkey"
            columns: ["chat_id"]
            isOneToOne: false
            referencedRelation: "chats"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "chat_messages_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          }
        ]
      }
      filemodels: {
        Row: {
          id: string
          user_id: string | null
          file_url: string
          file_name: string
          file_type: string | null
          file_size: number | null
          description: string | null
          is_public: boolean
          created_at: string
        }
        Insert: {
          id?: string
          user_id?: string | null
          file_url: string
          file_name: string
          file_type?: string | null
          file_size?: number | null
          description?: string | null
          is_public?: boolean
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string | null
          file_url?: string
          file_name?: string
          file_type?: string | null
          file_size?: number | null
          description?: string | null
          is_public?: boolean
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "filemodels_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          }
        ]
      }
      questionanswers: {
        Row: {
          id: string
          user_id: string | null
          question: string
          answer: string | null
          created_at: string
          updated_at: string
          is_answered: boolean
        }
        Insert: {
          id?: string
          user_id?: string | null
          question: string
          answer?: string | null
          created_at?: string
          updated_at?: string
          is_answered?: boolean
        }
        Update: {
          id?: string
          user_id?: string | null
          question?: string
          answer?: string | null
          created_at?: string
          updated_at?: string
          is_answered?: boolean
        }
        Relationships: [
          {
            foreignKeyName: "questionanswers_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          }
        ]
      }
      qanotifications: {
        Row: {
          id: string
          user_id: string | null
          question_id: string | null
          type: string
          is_read: boolean
          created_at: string
        }
        Insert: {
          id?: string
          user_id?: string | null
          question_id?: string | null
          type: string
          is_read?: boolean
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string | null
          question_id?: string | null
          type?: string
          is_read?: boolean
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "qanotifications_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questionanswers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "qanotifications_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          }
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      has_role: {
        Args: {
          _user_id: string
          _role: Database["public"]["Enums"]["app_role"]
        }
        Returns: boolean
      }
    }
    Enums: {
      app_role: "admin" | "user"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DefaultSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof Database },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends { schema: keyof Database }
  ? Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      app_role: ["admin", "user"],
    },
  },
} as const
