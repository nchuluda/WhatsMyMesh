//
//  SearchMusicTool.swift
//  WhatsMyMesh
//
//  Created by Claude on 3/4/26.
//

import Foundation
import FoundationModels
import MusicKit

/// Thread-safe storage for the found Song object, used to pass
/// the Song from the Tool's call() back to MeshManager for playback.
actor SongStore {
    var song: Song?

    func store(_ song: Song) {
        self.song = song
    }

    func retrieve() -> Song? {
        return song
    }
}

/// A FoundationModels Tool that searches Apple Music for a song matching a query.
/// The on-device model generates the search query based on the user's selected emotion.
nonisolated struct SearchMusicTool: Tool {
    let name = "searchMusic"
    let description = "Search Apple Music for a song matching a mood or query"

    let songStore: SongStore

    @Generable
    struct Arguments {
        @Guide(description: "A search query for Apple Music")
        var query: String
    }

    func call(arguments: Arguments) async throws -> String {
        var request = MusicCatalogSearchRequest(
            term: arguments.query,
            types: [Song.self]
        )
        request.limit = 1

        let response = try await request.response()

        guard let song = response.songs.first else {
            return "No songs found for query: \(arguments.query)"
        }

        await songStore.store(song)

        return "Found song: \(song.title) by \(song.artistName)"
    }
}
