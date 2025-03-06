import 'package:supabase_flutter/supabase_flutter.dart';

/*

Database helpers is just used to store various functions used throughout the app
- just a helper class to prevent having to remake code for basic database functionality
- also centralizes all interactions with the database

Rather than use a server or other handling, would need to pull in through helper functions anyways.

 */

// create variable for database which will be accessed later
final SupabaseClient supabase = Supabase.instance.client;

// class to call helpers from
class DataBase {
	// lists and maps to pass data to, currently just samples
	static List<Map> cases = [];

	// initialization of db
	static Future<void> init() async {
		await _tryInitialize();
	}

	// try to init, try catch for erros
	static Future<bool> _tryInitialize() async {
		try {
			await Supabase.initialize(
				// url and anonkey of supabase db
				url: 'https://cwuqeskcuzbzxxdkkgno.supabase.co',
				anonKey:
						'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN3dXFlc2tjdXpienh4ZGtrZ25vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA3NjAyNjEsImV4cCI6MjA0NjMzNjI2MX0.ll5U0251lxqwQU8691ZHXPFnBO8otEQljVYtjvhGCFs',
			);
			return false;
		} catch (e) {
			return true;
		}
	}

	// sample of what a methd with db would look like
	static Future<void> getCases() async {
		cases = supabase.from('Cases').select() as List<Map>;
	}

	static Future<String> getUserLocation() async {
		final response = await supabase.from('Account').select("location").single();
		final locationJson = Map<String, dynamic>.from(response['location']);
		return locationJson["selected-location-town"];
		
	}
}
