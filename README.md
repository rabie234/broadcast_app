# live_new_app

A Flutter video meeting app using VideoSDK with GetX state management. Users can create or join rooms, toggle mic/cam, and view participant streams.

## Features

- Create a VideoSDK room via REST and join with a token.
- Manage meeting state with a GetX controller around VideoSDK Room events.
- Render participant video tiles and basic meeting controls (mic, cam, leave).

## Tech stack

- Flutter app entry in lib/main.dart with GetMaterialApp and JoinScreen as home.
- VideoSDK for real-time audio/video (Room, Participant, Events).
- Wakelock to keep the screen on during meetings.

## Architecture

The flow connects JoinScreen, a small API helper, MeetingScreen, and a GetX controller around VideoSDK.

```mermaid
sequenceDiagram
    title Create and join a meeting
    participant U as User
    participant J as JoinScreen
    participant A as ApiService
    participant M as MeetingScreen
    participant C as MeetingController
    U->>J: Tap Create Meeting
    J->>A: POST createMeeting
    A-->>J: roomId
    J->>M: Navigate with roomId + token
    M->>C: createRoom(roomId, token)
    C->>VideoSDK: createRoom + join
    VideoSDK-->>C: roomJoined, participant events
    C-->>M: update() via GetX
    M-->>U: ParticipantTile grid and controls
