

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_pdm', 'pdm', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_pdm', 'pdm', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_pdm', 'pdm', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('pdm','pdm')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('pdm',1,'officer','Rekrut',500,'{}','{}'),
	('pdm',2,'sergeant','Pracownik',1000,'{}','{}'),
	('pdm',3,'lieutenant','Współwłaściciel',1500,'{}','{}'),
	('pdm',4,'boss','Właściciel',2000,'{}','{}')
;

