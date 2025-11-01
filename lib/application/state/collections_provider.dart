import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Collection {
  final String id;
  final String name;
  final List<String> gifIds;

  Collection({required this.id, required this.name, required this.gifIds});

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'gifIds': gifIds};

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    id: json['id'],
    name: json['name'],
    gifIds: List<String>.from(json['gifIds']),
  );
}

class CollectionsNotifier extends StateNotifier<List<Collection>> {
  CollectionsNotifier() : super([]) {
    loadCollections();
  }

  Future<void> loadCollections() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('collections') ?? [];
    state = list.map((e) => Collection.fromJson(jsonDecode(e))).toList();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final list = state.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('collections', list);
  }

  Future<void> createCollection(String name) async {
    final c = Collection(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      gifIds: [],
    );
    state = [...state, c];
    await save();
  }

  Future<void> addGif(String collectionId, String gifId) async {
    state = [
      for (final c in state)
        if (c.id == collectionId)
          Collection(id: c.id, name: c.name, gifIds: [...c.gifIds, gifId])
        else
          c,
    ];
    await save();
  }

  Future<void> removeGif(String collectionId, String gifId) async {
    state = [
      for (final c in state)
        if (c.id == collectionId)
          Collection(
            id: c.id,
            name: c.name,
            gifIds: c.gifIds.where((id) => id != gifId).toList(),
          )
        else
          c,
    ];
    await save();
  }

  Future<void> deleteCollection(String id) async {
    state = [
      for (final c in state)
        if (c.id != id) c,
    ];
    await save();
  }
}

final collectionsProvider =
    StateNotifierProvider<CollectionsNotifier, List<Collection>>((ref) {
      return CollectionsNotifier();
    });
