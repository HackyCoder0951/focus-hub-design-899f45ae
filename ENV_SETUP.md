# Environment Variables Setup

## Required Environment Variables

Add these to your `.env` file:

```bash
# Groq API Configuration
GROQ_API_KEY=gsk_your_groq_api_key_here

# Supabase Configuration (existing)
VITE_SUPABASE_URL=your_supabase_url_here
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key_here
```

## Getting Your Groq API Key

1. Visit [Groq Console](https://console.groq.com/)
2. Sign up for a free account
3. Go to API Keys section
4. Create a new API key
5. Copy the key (starts with `gsk_`)

## Testing the Setup

1. Add your API key to `.env`
2. Run the development server: `npm run dev`
3. Use the `AITest` component to verify the integration
4. Or go to Q&A page and try posting a question

## Cost Information

- **llama3-8b-8192**: $0.05 per 1M tokens
- **Typical answer**: ~100-200 tokens
- **Cost per answer**: ~$0.000005-0.00001
- **1000 answers**: ~$0.005-0.01 