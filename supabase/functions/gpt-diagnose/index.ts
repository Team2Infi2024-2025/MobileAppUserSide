import { serve } from "https://deno.land/std@0.182.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import OpenAI from "https://esm.sh/openai@4.0.0";

const supabaseUrl = Deno.env.get("SUPABASE_URL");
const supabaseAnonKey = Deno.env.get("SUPABASE_ANON_KEY");
const supabase = createClient(supabaseUrl, supabaseAnonKey);

serve(async (req) => {
    try {
        console.log("Received request:", req);

        if (req.method !== "POST") {
            console.error("Invalid method:", req.method);
            return new Response("Only POST requests are allowed", { status: 405 });
        }

        const { symptoms, medicalHistory, age, gender, lifestyleFactors } = await req.json();
        console.log("Received medical data:", { symptoms, medicalHistory, age, gender, lifestyleFactors });

        if (!symptoms || typeof symptoms !== "string" || symptoms.trim() === "") {
            console.error("Invalid or missing 'symptoms' in request body");
            return new Response("Invalid 'symptoms' in request body", { status: 400 });
        }

        const apiKey = Deno.env.get("OPENAI_API_KEY");
        if (!apiKey) {
            console.error("Missing OpenAI API key");
            return new Response("Missing OpenAI API key", { status: 500 });
        }
        console.log("OpenAI API key is present");

        const openai = new OpenAI({ apiKey });
        const query = `Based on the following medical information, suggest a possible diagnosis and potential next steps: \n\nSymptoms: ${symptoms}\nMedical History: ${medicalHistory || "Not provided"}\nAge: ${age || "Not provided"}\nGender: ${gender || "Not provided"}\nLifestyle Factors: ${lifestyleFactors || "Not provided"}. Also just give general health information if prompted to.`;
        
        console.log("Sending query to OpenAI:", query);

        const response = await openai.chat.completions.create({
            model: "gpt-4o-mini",
            messages: [{ role: "user", content: query }],
            temperature: 0.7,
            max_tokens: 200,
        });

        console.log("OpenAI response:", response);

        const diagnosis = response.choices?.[0]?.message?.content?.trim();
        if (!diagnosis) {
            console.error("Failed to generate diagnosis");
            return new Response("Error: Failed to generate diagnosis", { status: 500 });
        }

        console.log("Generated diagnosis:", diagnosis);

        return new Response(diagnosis, {
            headers: { "Content-Type": "text/plain" },
        });
    } catch (error) {
        console.error("Unexpected error:", error.message);
        return new Response(`Error: ${error.message}`, { status: 500 });
    }
});

/*
Sample implementation:

await supabase.functions.invoke('diagnose-disease', {
    body: { symptoms: "fever, cough, fatigue", medicalHistory: "asthma", age: 30, gender: "male", lifestyleFactors: "smokes occasionally" }
});
*/
