// Quick test script for Groq integration
import Groq from 'groq-sdk';

// Initialize Groq (you'll need to set GROQ_API_KEY in environment)
const groq = new Groq({
  apiKey: process.env.GROQ_API_KEY
});

async function testGroq() {
  try {
    console.log('🧪 Testing Groq API integration...');
    
    const completion = await groq.chat.completions.create({
      model: "llama3-8b-8192",
      messages: [
        {
          role: "system",
          content: "You are a helpful expert. Provide a concise answer."
        },
        {
          role: "user",
          content: "What is React?"
        }
      ],
      max_tokens: 100,
      temperature: 0.7,
    });

    console.log('✅ Groq API is working!');
    console.log('📝 Response:', completion.choices[0].message.content);
    console.log('⚡ Model used:', completion.model);
    console.log('💰 Tokens used:', completion.usage.total_tokens);
    
  } catch (error) {
    console.error('❌ Error testing Groq:', error.message);
    console.log('💡 Make sure GROQ_API_KEY is set in your environment');
  }
}

// Run the test
testGroq(); 