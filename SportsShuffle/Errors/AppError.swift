//
//  AppError.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/12/26.
//

import Foundation

nonisolated struct AppError: Codable, Equatable {
    
    let code: AppErrorCode
    let message: String?
    
    nonisolated enum AppErrorCode: String, Codable, Equatable {
        case actionInProgress = "action_in_progress"
        case addPlayerFailed = "add_player_failed"
        case badDelta = "bad_delta"
        case badIndex = "bad_index"
        case badToken = "bad_token"
        case cardNotInHand = "card_not_in_hand"
        case cooldown
        case createFailed = "create_failed"
        case eventAlreadyPending = "event_already_pending"
        case eventIdMismatch = "event_id_mismatch"
        case gameNotPlaying = "game_not_playing"
        case invalidDelta = "invalid_delta"
        case invalidEvent = "invalid_event"
        case invalidReaction = "invalid_reaction"
        case invalidVote = "invalid_vote"
        case joinFailed = "join_failed"
        case leaveFailed = "leave_failed"
        case locked
        case missingCard = "missing_card"
        case missingKey = "missing_key"
        case missingPlayerKey = "missing_player_key"
        case noHand = "no_hand"
        case noInvite = "no_invite"
        case noPendingEvent = "no_pending_event"
        case noPlayerForKey = "no_player_for_key"
        case noVoters = "no_voters"
        case notEnoughPlayers = "not_enough_players"
        case notInRoom = "not_in_room"
        case notHost = "not_host"
        case notPlaying = "not_playing"
        case playerNotFound = "player_not_found"
        case proposerCannotVote = "proposer_cannot_vote"
        case reactionCooldown = "reaction_cooldown"
        case roomNotFound = "room_not_found"
        case serverError = "server_error"
        case tokenExpired = "token_expired"
        case voteExpired = "vote_expired"
    }
}

