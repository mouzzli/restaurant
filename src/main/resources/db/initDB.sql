DROP TABLE IF EXISTS TEST;
DROP SEQUENCE IF EXISTS global_seq;

CREATE SEQUENCE global_seq START WITH 100000;

CREATE TABLE  TEST(ID INT PRIMARY KEY, NAME VARCHAR(255));