# Groq Models Guide

## Available Models

### 1. **llama3-8b-8192** (Current - Recommended)
- **Speed**: ⚡⚡⚡⚡⚡ Very Fast
- **Cost**: $0.05 per 1M tokens
- **Best for**: General Q&A, quick responses, cost-effective solutions
- **Use case**: Perfect for your Q&A feature

### 2. **llama3-70b-8192**
- **Speed**: ⚡⚡⚡⚡ Fast
- **Cost**: $0.59 per 1M tokens
- **Best for**: Complex questions, detailed explanations
- **Use case**: When you need higher quality answers

### 3. **mixtral-8x7b-32768**
- **Speed**: ⚡⚡⚡⚡ Fast
- **Cost**: $0.24 per 1M tokens
- **Best for**: Technical questions, code explanations
- **Use case**: Programming and technical Q&A

### 4. **gemma2-9b-it**
- **Speed**: ⚡⚡⚡⚡⚡ Very Fast
- **Cost**: $0.10 per 1M tokens
- **Best for**: General purpose, good balance
- **Use case**: Balanced performance and cost

## How to Change Models

### Option 1: Change in API File
Edit `src/api/ai-answers.js`:

```javascript
model: "llama3-70b-8192", // Change this line
```

### Option 2: Environment Variable
Add to your `.env`:
```bash
GROQ_MODEL=llama3-70b-8192
```

Then update the API file:
```javascript
model: process.env.GROQ_MODEL || "llama3-8b-8192",
```

## Cost Comparison

| Model | Cost per 1M tokens | Speed | Quality | Best For |
|-------|-------------------|-------|---------|----------|
| llama3-8b-8192 | $0.05 | ⚡⚡⚡⚡⚡ | Good | General Q&A |
| gemma2-9b-it | $0.10 | ⚡⚡⚡⚡⚡ | Good | Balanced |
| mixtral-8x7b-32768 | $0.24 | ⚡⚡⚡⚡ | Better | Technical |
| llama3-70b-8192 | $0.59 | ⚡⚡⚡⚡ | Best | Complex |

## Monthly Cost Estimates

### Using llama3-8b-8192 (Current)
- 100 questions: ~$0.005
- 1,000 questions: ~$0.05
- 10,000 questions: ~$0.50

### Using llama3-70b-8192
- 100 questions: ~$0.06
- 1,000 questions: ~$0.59
- 10,000 questions: ~$5.90

## Recommendation

**Start with llama3-8b-8192** because:
- ✅ Very fast responses
- ✅ Very cost-effective
- ✅ Good quality for Q&A
- ✅ Perfect for MVP

You can always upgrade to a more expensive model later if you need higher quality answers. 