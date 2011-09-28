

typedef enum {
	GuluTargetType_photo=0,
    GuluTargetType_review,
    GuluTargetType_dish,
    GuluTargetType_place,
    GuluTargetType_mission,
    GuluTargetType_user,
    GuluTargetType_task,
    GuluTargetType_MissionGroup,
    GuluTargetType_Evenet,
    GuluTargetType_Chat,
    GuluTargetType_Unknown=99

}GuluTargetType;

typedef enum {
	GULU_CHATOBJECTTYPE_EVENT=0,
    GULU_CHATOBJECTTYPE_MISSION,
    GULU_CHATOBJECTTYPE_HUNGRY
    
}GuluChatObjectType;


typedef enum {
	GuluFavoriteType_dish=0,
    GuluFavoriteType_place,
    GuluFavoriteType_review,
    GuluFavoriteType_user,
    GuluFavoriteType_mission
    
}GuluFavoriteType;

typedef enum {
	GuluToDoObjectType_dish=0,
    GuluToDoObjectType_place
    
}GuluToDoObjectType;


typedef enum {
	GULU_NOTIFY_UNDEFINED = 0,
    GULU_NOTIFY_CHAT,
    GULU_NOTIFY_SENTCHAT,
    GULU_NOTIFY_EMAIL,
    GULU_NOTIFY_MOBILE,
    GULU_NOTIFY_WEB,
    GULU_NOTIFY_SUGGEST,        // friend has suggested a website
    GULU_NOTIFY_EVENT,          // an Event has been suggested
    GULU_NOTIFY_HUNGRY,         // user clicked on the I'm hungry button on the website
    GULU_NOTIFY_INVITE,         // you have been invited to an event.
    GULU_NOTIFY_FRIEND,         // +FRIEND
    GULU_NOTIFY_MISSION_RECRUIT,
    GULU_NOTIFY_MISSION_CHALLENGER,
    GULU_NOTIFY_MISSION_SPECTATOR,
    GULU_NOTIFY_LIKES,          // Likes an content_object
    GULU_NOTIFY_COMMENTED,      // commented on your post
    GULU_NOTIFY_FOLLOWS,        // follows
    GULU_NOTIFY_FRIEND_ACCEPT,
    GULU_NOTIFY_TAG_IN_POST,
    GULU_NOTIFY_TAG_IN_POST_EVENT
    
} GuluNotifyType;

typedef enum {
	GULU_MISSIONTYPE_DARE = 0,
    GULU_MISSIONTYPE_FOODGUIDE,
    GULU_MISSIONTYPE_PRIVATEGROUP,
    GULU_MISSIONTYPE_TIMECRITICAL,
    GULU_MISSIONTYPE_TREASUREHUNT
} GuluMissionType;

typedef enum {
	GULU_MISSIONMEMBERSTATUS_PENDING = 0,
    GULU_MISSIONMEMBERSTATUS_ACTIVE,
    GULU_MISSIONMEMBERSTATUS_SPECTATOR
} GuluMissionMemberStatus;

typedef enum {
	GULU_MISSIONGROUPSTATUS_NOT_COMPLETED = 0,
    GULU_MISSIONGROUPSTATUS_DONE,
    GULU_MISSIONGROUPSTATUS_FAILED,
    GULU_MISSIONGROUPSTATUS_PASSED,
    GULU_MISSIONGROUPSTATUS_A_PLUS
} GuluMissionGroupStatus;

typedef enum {
	GULU_WALLFEEDTYPE_WALL = 0,
    GULU_WALLFEEDTYPE_REVIEW
} GuluWallFeedType;

typedef enum {
	GULU_FRIENDSTATUS_NOT_REQUEST = 0,
    GULU_FRIENDSTATUS_PENDING,
    GULU_FRIENDSTATUS_ACCEPT,
    GULU_FRIENDSTATUS_REJECT
} GuluFriendStatus;

typedef enum {
	GULU_EVENTSTATUS_PENDING = 0,
    GULU_EVENTSTATUS_ACCEPT,
    GULU_EVENTSTATUS_DECLINED
} GuluEventStatus;

typedef enum {
	GULU_TASKSTATUS_NOT_COMPLETED = 0,
    GULU_TASKSTATUS_DONE,
    GULU_TASKSTATUS_FAILED
} GuluTaskStatus;






