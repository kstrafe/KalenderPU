CREATE TABLE SystemUser
(
	systemUserId  	int 		NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	rank 		int,
	username 	varchar(255) 	UNIQUE, 
	fname 		varchar(255),
	lname 		varchar(255),
	hashedPW 	varchar(255),

	PRIMARY KEY (systemUserId)
);

CREATE TABLE PersonalEvent
(
	eventId 	int NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	description	varchar(255),
	time 		timestamp,
	systemUserId 		int,
	timeEnd		timestamp,
	warntime    int,
	PRIMARY KEY (eventId),
	FOREIGN KEY (systemUserId) REFERENCES SystemUser(systemUserId)
);

CREATE TABLE Room
(
	roomId		int NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	size 		int,
	location	varchar(255),
	roomName	varchar(255) UNIQUE,
	PRIMARY KEY (roomId)
);

CREATE TABLE Booking
(
	bookingId		int NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	adminId			int NOT NULL,
	description		varchar(255),
	bookingName		varchar(255),
	roomId			int,
	warntime		timestamp,
	timeBegin		timestamp,
	timeEnd			timestamp,
	PRIMARY KEY (bookingId),
	FOREIGN KEY (roomId) REFERENCES ROOM(roomId),
	FOREIGN KEY (adminId) REFERENCES SystemUser(systemUserId)
);

CREATE TABLE SystemGroup
(
	groupId 	int 		NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	groupAdminId	int			NOT NULL,
	groupName	varchar(255) UNIQUE, 
	parentGroupId int,
	CHECK (groupId != parentGroupId),
	PRIMARY KEY (groupId),
	FOREIGN KEY (parentGroupId) REFERENCES SystemGroup(groupId) ON DELETE SET NULL,
	FOREIGN KEY (groupAdminId) REFERENCES SystemUser(systemUserId)
);

CREATE TABLE GroupMember
(
	systemUserId		int		NOT NULL,
	groupId		int		NOT NULL,
	PRIMARY KEY (systemUserId, groupId),
	FOREIGN KEY (systemUserId) REFERENCES SystemUser (systemUserId),
	FOREIGN KEY (groupId) REFERENCES SystemGroup (groupId)
);

CREATE TABLE Invitation
(
	systemUserId 		int NOT NULL,
	bookingId 			int NOT NULL,
	status				int WITH DEFAULT 0,
	wantsWarning		boolean WITH DEFAULT true,
	PRIMARY KEY (systemUserId, bookingId)
);

CREATE TABLE Notification
(
	n_Id 			int NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	message 		varchar(255),
	duration		varchar(255),
	seen 			boolean,
	bookingId		int NOT NULL,
	groupId 		int, 
	systemUserId 			int, 
	CHECK (groupId IS NOT NULL OR systemUserId IS NOT NULL),
	PRIMARY KEY (n_Id),
	FOREIGN KEY (bookingId) REFERENCES Booking(bookingId),
	FOREIGN KEY (groupId) REFERENCES SystemGroup(groupId),
	FOREIGN KEY (systemUserId) REFERENCES SystemUser(systemUserId)
);
