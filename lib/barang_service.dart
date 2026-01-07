import 'package:supabase_flutter/supabase_flutter.dart';

class BarangService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getBarang() async {
    final data = await supabase
        .from('barang')
        .select()
        .order('created_at', ascending: false);

        return List<Map<String, dynamic>>.from(data);
  }
}
