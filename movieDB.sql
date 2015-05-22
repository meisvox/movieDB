PRAGMA foreign_keys=1;
.headers on
.mode columns

.open movieDB.db

DROP TABLE MOVIE;
DROP TABLE ACTOR;
DROP TABLE DIRECTOR;
DROP TABLE SCREENWRITER;
DROP TABLE LOCATION;
DROP TABLE SONG;
DROP TABLE MOVIE_LOCATION;
DROP TABLE MOVIE_SONG;
DROP TABLE WRITTEN_BY;
DROP TABLE ACTED_IN;

CREATE TABLE MOVIE (
	m_title VARCHAR(60) NOT NULL,
	m_release_date DATE NOT NULL,
	genre VARCHAR(15),
	minutes INT,
	language VARCHAR(20),
	m_producer VARCHAR(30),
	origin VARCHAR(20),
	PRIMARY KEY (m_title, m_release_date)
);

CREATE TABLE ACTOR(
	a_ID INT NOT NULL CHECK(a_ID > 0 AND a_ID <= 99999),
	fname VARCHAR(20) NOT NULL,
	lname VARCHAR(20) NOT NULL,
	a_DOB DATE,
	gender CHAR CHECK(gender = 'M' OR gender = 'F'),
	a_nationality VARCHAR(20),
	a_active_form VARCHAR(20),
	PRIMARY KEY(a_ID)
);

CREATE TABLE DIRECTOR(
	d_ID INT NOT NULL CHECK(d_ID > 0 AND d_ID <= 99999),
	fname VARCHAR(20) NOT NULL,
	lname VARCHAR(20) NOT NULL,
	d_DOB DATE,
	gender CHAR CHECK(gender = 'M' OR gender = 'F'),
	d_nationality VARCHAR(20),
	d_active_form VARCHAR(20),
	movie VARCHAR(60) NOT NULL,
	movie_release DATE NOT NULL,
	PRIMARY KEY(d_ID),
	FOREIGN KEY(movie) REFERENCES MOVIE(m_title) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(movie_release) REFERENCES MOVIE(m_release_date) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE SCREENWRITER(
	w_ID INT NOT NULL CHECK(w_ID > 0 AND w_ID <= 99999),
	fname VARCHAR(20) NOT NULL,
	lname VARCAHR(20) NOT NULL,
	w_DOB DATE,
	gender CHAR CHECK(gender = 'M' OR gender = 'F'),
	w_nationality VARCHAR(20),
	w_active_form VARCHAR(20),
	PRIMARY KEY(w_ID)
);

CREATE TABLE LOCATION(
	country VARCHAR(30) NOT NULL,
	region VARCHAR(30) NOT NULL,
	place VARCHAR(30) NOT NULL,
	PRIMARY KEY(country, region, place)
);

CREATE TABLE SONG(
	s_title VARCHAR(30) NOT NULL,
	s_artist VARCHAR(20) NOT NULL,
	s_release_date DATE NOT NULL,
	s_producer VARCHAR(30),
	album VARCHAR(20),
	PRIMARY KEY(s_title, s_artist, s_release_date)
);

CREATE TABLE MOVIE_LOCATION(
	movie VARCHAR(60) NOT NULL,
	movie_release DATE NOT NULL,
	country VARCHAR(30) NOT NULL,
	region VARCHAR(30) NOT NULL,
	place VARCHAR(30) NOT NULL,
	PRIMARY KEY(movie, movie_release, country, region, place),
	FOREIGN KEY(movie) REFERENCES MOVIE(m_title) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(movie_release) REFERENCES MOVIE(m_release_date) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(country) REFERENCES LOCATION(country) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(region) REFERENCES LOCATION(region) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(place) REFERENCES LOCATION(place) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE MOVIE_SONG(
	movie VARCHAR(60) NOT NULL,
	movie_release DATE NOT NULL,
	song VARCHAR(30) NOT NULL,
	song_release DATE NOT NULL,
	artist VARCHAR(20) NOT NULL,
	PRIMARY KEY(movie, movie_release, song, song_release, artist),
	FOREIGN KEY(movie) REFERENCES MOVIE(m_title) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(movie_release) REFERENCES MOVIE(m_release_date) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(song) REFERENCES SONG(s_title) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(song_release) REFERENCES SONG(s_release_date) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(artist) REFERENCES SONG(s_artist) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE WRITTEN_BY(
	movie VARCHAR(60) NOT NULL,
	movie_release DATE NOT NULL,
	writer INT NOT NULL CHECK(writer > 0 AND writer <= 99999),
	PRIMARY KEY(movie, movie_release, writer),
	FOREIGN KEY(movie) REFERENCES MOVIE(m_title) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(movie_release) REFERENCES MOVIE(m_release_date) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(writer) REFERENCES SCREENWRITER(w_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ACTED_IN(
	movie VARCHAR(60) NOT NULL,
	movie_release DATE NOT NULL,
	actor INT NOT NULL CHECK(actor > 0 AND actor <= 99999),
	PRIMARY KEY(movie, movie_release, actor),
	FOREIGN KEY(movie) REFERENCES MOVIE(m_title) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(movie_release) REFERENCES MOVIE(m_release_date) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(actor) REFERENCES ACTOR(a_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

/* MOVIE TABLE INSERT STATEMENTS */
INSERT INTO MOVIE VALUES('Star Wars: Episode IV', '1977-05-25', 'Fantasy', 121, 'English', 'Lucasfilm Ltd', 'USA');
INSERT INTO MOVIE VALUES('Star Wars: Episode V', '1980-05-21', 'Fantasy', 124, 'English', 'Lucasfilm Ltd', 'USA');
INSERT INTO MOVIE VALUES('Star Wars: Episode VI', '1983-05-25', 'Fantasy', 131, 'English', 'Lucasfilm Ltd', 'USA');
INSERT INTO MOVIE VALUES('The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', 'Fantasy', 178, 'English', 'WingNut Films', 'USA');
INSERT INTO MOVIE VALUES('The Lord of the Rings: The Two Towers', '2002-12-18', 'Fantasy', 179, 'English', 'WingNut Films', 'USA');
INSERT INTO MOVIE VALUES('The Lord of the Rings: The Return of the King', '2003-12-17', 'Fantasy', 201, 'English', 'WingNut Films', 'USA');
INSERT INTO MOVIE VALUES('2001: A Space Odessey', '1968-04-03', 'Sci-Fi', 148, 'English', 'Stanley Kubrick', 'USA');
INSERT INTO MOVIE VALUES('The Princess Bride', '1987-09-25', 'Adventure', 98, 'English', 'ACT III Communications', 'USA');
INSERT INTO MOVIE VALUES('Robin Hood: Men in Tights', '1993-07-28', 'Comedy', 104, 'English', 'Mel Brooks', 'USA');
INSERT INTO MOVIE VALUES('Caddyshack', '1980-07-25', 'Comedy', 98, 'English', 'Douglas Kenney', 'USA');
INSERT INTO MOVIE VALUES('Ghostbusters', '1984-06-08', 'Comedy', 107, 'English', 'Ivan Reitman', 'USA');

/* ACTOR TABLE INSERT STATEMENTS */
INSERT INTO ACTOR VALUES(10001, 'Bill', 'Murray', '1950-09-21', 'M', 'American', 'Comedy'); /* Caddyshack */
INSERT INTO ACTOR VALUES(10002, 'Sigourney', 'Weaver', '1949-09-21', 'F', 'American', 'Comedy'); /* Ghostbusters */
INSERT INTO ACTOR VALUES(10003, 'Ian', 'McKellen', '1939-05-22', 'M', 'American', 'Drama'); /* The Lord of the Rings */
INSERT INTO ACTOR VALUES(10004, 'Harrison', 'Ford', '1942-07-13', 'M', 'American', 'Action'); /* Star Wars */
INSERT INTO ACTOR VALUES(10005, 'Robin', 'Wright', '1966-04-08', 'F', 'American', 'Drama'); /* The Princess Bride */
INSERT INTO ACTOR VALUES(10006, 'Brad', 'Pitt', '1963-12-18', 'M', 'American', 'Drama'); /* */
INSERT INTO ACTOR VALUES(10007, 'Scarlett', 'Johansson', '1984-11-22', 'F', 'American', 'Drama'); /* */
INSERT INTO ACTOR VALUES(10008, 'Cary', 'Elwes', '1969-11-04', 'M', 'American', 'Drama'); /* Robin Hood: Men in Tights */
INSERT INTO ACTOR VALUES(10009, 'Natalie', 'Portman', '1981-06-09', 'F', 'American', 'Drama'); /* */
INSERT INTO ACTOR VALUES(10010, 'Carrie', 'Fisher', '1956-10-21', 'F', 'American', 'Action'); /* Star Wars */

/* SCREENWRITER TABLE INSERT STATEMENTS */
INSERT INTO SCREENWRITER VALUES(1, 'George', 'Lucas', '1944-05-14', 'M','American', 'Action'); /* Star Wars Ep. 4-6*/
INSERT INTO SCREENWRITER VALUES(2, 'Lawrence', 'Kasdan', '1949-01-14', 'M', 'American', 'Action'); /*Star Wars Ep. 5-6*/
INSERT INTO SCREENWRITER VALUES(3, 'Leigh', 'Brackett', '1915-12-07', 'F', 'American', 'Action'); /*Star Wars Ep. 5*/
INSERT INTO SCREENWRITER VALUES(4, 'Fran', 'Walsh', '1959-01-10', 'F', 'New Zealander', 'Action'); /*Lord of the Rings*/
INSERT INTO SCREENWRITER VALUES(5, 'Stephen', 'Sinclair', '1953-03-07', 'M', 'New Zealander', 'Action'); /*The Two Towers*/
INSERT INTO SCREENWRITER VALUES(6, 'Arthur', 'Clark', '1917-12-16','M', 'British', 'Action'); /*2001: A Space Odyssey*/
INSERT INTO SCREENWRITER VALUES(7, 'William', 'Goldman', '1931-08-12','M', 'American', 'Drama'); /*Princess Bride*/
INSERT INTO SCREENWRITER VALUES(8, 'Evan', 'Chandler', '1944-01-25','M', 'American', 'Comedy'); /*Robin Hood*/
INSERT INTO SCREENWRITER VALUES(9, 'Brian', 'Doyle-Murray', '1945-10-31','M', 'American', 'Comedy'); /*Caddyshack*/
INSERT INTO SCREENWRITER VALUES(10, 'Dan', 'Akroyd', '1952-07-01','M', 'American', 'Comedy'); /*Ghostbusters*/

/* WRITTEN_BY TABLE INSERT STATEMENTS */
INSERT INTO WRITTEN_BY VALUES('Star Wars: Episode IV', '1977-05-25', 1);
INSERT INTO WRITTEN_BY VALUES('Star Wars: Episode V', '1980-05-21', 2);
INSERT INTO WRITTEN_BY VALUES('Star Wars: Episode V', '1980-05-21', 3);
INSERT INTO WRITTEN_BY VALUES('Star Wars: Episode VI', '1983-05-25', 2);
INSERT INTO WRITTEN_BY VALUES('The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', 4);
INSERT INTO WRITTEN_BY VALUES('The Lord of the Rings: The Two Towers', '2002-12-18', 5);
INSERT INTO WRITTEN_BY VALUES('The Lord of the Rings: The Return of the King', '2003-12-17', 4);
INSERT INTO WRITTEN_BY VALUES('2001: A Space Odessey', '1968-04-03', 6);
INSERT INTO WRITTEN_BY VALUES('The Princess Bride', '1987-09-25', 7);
INSERT INTO WRITTEN_BY VALUES('Robin Hood: Men in Tights', '1993-07-28', 8);
INSERT INTO WRITTEN_BY VALUES('Caddyshack', '1980-07-25', 9);
INSERT INTO WRITTEN_BY VALUES('Ghostbusters', '1984-06-08', 10);

/* ACTED_IN TABLE INSERT STATEMENTS */
INSERT INTO ACTED_IN VALUES('Star Wars: Episode IV', '1977-05-25', 10004);
INSERT INTO ACTED_IN VALUES('Star Wars: Episode IV', '1977-05-25', 10010);
INSERT INTO ACTED_IN VALUES('The Princess Bride', '1987-09-25', 10005);
INSERT INTO ACTED_IN VALUES('Ghostbusters', '1984-06-08', 10001);
INSERT INTO ACTED_IN VALUES('Ghostbusters', '1984-06-08', 10002);
INSERT INTO ACTED_IN VALUES('Caddyshack', '1980-07-25', 10001);
INSERT INTO ACTED_IN VALUES('Star Wars: Episode V', '1980-05-21', 10004);
INSERT INTO ACTED_IN VALUES('Star Wars: Episode V', '1980-05-21', 100010);
INSERT INTO ACTED_IN VALUES('The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', 10003);
INSERT INTO ACTED_IN VALUES('The Lord of the Rings: The Two Towers', '2002-12-18', 10003);
