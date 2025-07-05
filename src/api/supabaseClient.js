import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = "https://hfiltwodcwlqwxrwfjyp.supabase.co";
const SUPABASE_PUBLISHABLE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhmaWx0d29kY3dscXd4cndmanlwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEyMDM1NjUsImV4cCI6MjA2Njc3OTU2NX0.hZtaDcr5z_l0YlsMj47zO4I6zW1lEmt9QM8ZJAJMouI";

export const supabase = createClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY); 