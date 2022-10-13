create database test; 

use test;

CREATE TABLE article (
	uId INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR (64) NOT NULL,
    keywordId INT NOT NULL, 
    
	CONSTRAINT `FK_articleKeywordId` FOREIGN KEY (`keywordId`)
		REFERENCES `keyword` (`keywordId`) ON DELETE RESTRICT ON UPDATE RESTRICT
    
);

CREATE TABLE issue (
	uIdentifier VARCHAR(100) NOT NULL PRIMARY KEY, 
    publicationDate DATE NOT NULL, 
    copiesSold INT NOT NULL,
    articleId INT NOT NULL,
    
	CONSTRAINT `FK_issueArticleId` FOREIGN KEY (`articleId`)
		REFERENCES `article` (`uId`) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE author (
	authorId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL,
    affiliation VARCHAR(64) NOT NULL, 
    email VARCHAR(64) NOT NULL,
    articleId INT NOT NULL,
    
	CONSTRAINT `FK_authorArticleId` FOREIGN KEY (`articleId`)
		REFERENCES `article` (`uId`) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE keyword (
	keywordId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    keywordPhrase VARCHAR(255) NOT NULL,
    locationId INT NOT NULL,
    
    CONSTRAINT `FK_keywordLocationId` FOREIGN KEY (`locationId`)
		REFERENCES `location` (`keywordPhraseLocation`) ON DELETE RESTRICT ON UPDATE RESTRICT

);



CREATE TABLE location (
	keywordPhraseLocation INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);


CREATE TABLE researchTopics(
	rId INT NOT NULL PRIMARY KEY, 
    words VARCHAR(255),
    keywordId INT NOT NULL, 
    
	CONSTRAINT `FK_articleKeywordId` FOREIGN KEY (`keywordId`)
		REFERENCES `keyword` (`keywordId`) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE keywordResearchTopics(
	keywordId INT NOT NULL, 
    rId INT NOT NULL,
    PRIMARY KEY(keywordId, rId),
    
    
	CONSTRAINT `FK_keywordResearchTopicsKeywordId` FOREIGN KEY (`keywordId`)
		REFERENCES `keyword` (`keywordId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
        
	CONSTRAINT `FK_keywordResearchTopicsRId` FOREIGN KEY (`rId`)
		REFERENCES `researchTopics` (`rId`) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE articleKeyword (
	articleId INT NOT NULL, 
    keywordId INT NOT NULL,
    PRIMARY KEY (articleId, keywordId),
    
    CONSTRAINT `FK_articleKeywordKeywordId` FOREIGN KEY (`keywordId`)
		REFERENCES `keyword` (`keywordId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
        
	CONSTRAINT `FK_articleKeywordArticleId` FOREIGN KEY (`articleId`)
		REFERENCES `article` (`uId`) ON DELETE RESTRICT ON UPDATE RESTRICT
	
);