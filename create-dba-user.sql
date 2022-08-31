CLEAR SCREEN

PROMPT DBA User Creation
PROMPT ------------------

ACCEPT username CHAR FORMAT A30 PROMPT "Username: "
ACCEPT password CHAR FORMAT A30 PROMPT "Password: "
PROMPT

PROMPT Creating user (&username)...

CREATE USER &username
IDENTIFIED BY "&password"
DEFAULT TABLESPACE users;

PROMPT User (&username) created.
PROMPT

PROMPT Grant role (DBA) to user (&username)...

GRANT dba to &username;

PROMPT Role (DBA) granted to user (&username).
