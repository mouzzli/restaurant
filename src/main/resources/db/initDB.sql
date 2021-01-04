DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS dishes;
DROP TABLE IF EXISTS votes;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS users;

DROP SEQUENCE IF EXISTS global_seq;

CREATE SEQUENCE global_seq START WITH 10000;

CREATE TABLE restaurants
(
    id         BIGINT    DEFAULT global_seq.nextval PRIMARY KEY,
    name       VARCHAR                 NOT NULL,
    registered TIMESTAMP DEFAULT now() NOT NULL,
    enabled    BOOLEAN   DEFAULT TRUE  NOT NULL
);
CREATE UNIQUE INDEX restaurant_unique_name_idx ON restaurants (name);

CREATE TABLE users
(
    id         BIGINT    DEFAULT global_seq.nextval PRIMARY KEY,
    name       VARCHAR                 NOT NULL,
    email      VARCHAR                 NOT NULL,
    password   VARCHAR                 NOT NULL,
    registered TIMESTAMP DEFAULT now() NOT NULL,
    enabled    BOOLEAN   DEFAULT TRUE  NOT NULL
);
CREATE UNIQUE INDEX users_unique_email_idx ON users (email);

CREATE TABLE user_roles
(
    user_id INTEGER NOT NULL,
    role    VARCHAR,
    CONSTRAINT user_roles_idx UNIQUE (user_id, role),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE dishes
(
    id            BIGINT DEFAULT global_seq.nextval PRIMARY KEY,
    restaurant_id INTEGER              NOT NULL,
    name          VARCHAR              NOT NULL,
    price         INTEGER              CHECK NOT NULL,
    date    DATE   DEFAULT now() NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants (id) ON DELETE CASCADE,
    CONSTRAINT dish_unique_restaurant_name_date_idx UNIQUE (restaurant_id, name, date)
);
CREATE INDEX dish_date_idx ON dishes (date);

CREATE TABLE votes
(
    id            BIGINT DEFAULT global_seq.nextval PRIMARY KEY,
    user_id       INTEGER              NOT NULL,
    restaurant_id INTEGER              NOT NULL,
    date    DATE   DEFAULT now() NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants (id) ON DELETE CASCADE
);
CREATE UNIQUE INDEX vote_unique_user_date_idx ON votes (user_id, date);