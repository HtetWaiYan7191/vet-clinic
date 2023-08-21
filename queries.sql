SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';

SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts<3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5 ;

SELECT * FROM animals WHERE neutered = TRUE;

SELECT * FROM animals WHERE name NOT IN ('Gabumon');

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3 ;

BEGIN;
UPDATE animals SET species = 'unspecified' ;
select name, species from animals;
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE'%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
select name , species from animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_all_born_after_Jan1st22;
UPDATE animals SET weight_kg = weight_kg * -1 ;
ROLLBACK TO delete_all_born_after_Jan1st22;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0 ;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) as total_escape FROM animals GROUP BY neutered ORDER BY total_escape DESC LIMIT 1;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species;


SELECT name as animal_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name= 'Melody Pond';
SELECT animals.name AS animal_name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name AS owner_name, animals.name AS animal_name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id ORDER BY owners.full_name;
SELECT species.name AS species , COUNT(animals.id) AS total_animals FROM species LEFT JOIN animals ON species.id = animals.species_id GROUP BY species.name;
SELECT animals.name AS animal_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell';   
SELECT animals.name AS animal_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animal.escape_attemp = 0;
SELECT owners.full_name AS name , COUNT(animals.id) AS total_animals FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY total_animals DESC LIMIT 1;



SELECT a.name FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'William Tatcher' ORDER BY v.visit_date DESC LIMIT 1;

SELECT COUNT(DISTINCT a.id) FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Stephanie Mendez';

SELECT vt.name AS vet_name , s.name AS speciality FROM vets vt LEFT JOIN specializations sp ON vt.id = sp.vet_id  LEFT JOIN species s ON sp.species_id = s.id ORDER BY vt.name;

SELECT a.name FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Stephanie Mendez' AND vt.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name FROM animals a JOIN visits v ON a.id = v.animal_id GROUP BY a.name ORDER BY COUNT(a.id) DESC LIMIT 1;

SELECT a.name FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Maisy Smith' ORDER BY v.visit_date ASC LIMIT 1;

SELECT a.name AS animal_name, vt.name AS vet_info , v.visit_date AS visit_date FROM animals a JOIN visits v ON  a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id ORDER BY v.visit_date DESC LIMIT 1;

SELECT COUNT(*) FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id WHERE sp.vet_id IS NULL;

SELECT s.name AS Maisy_speciality FROM species JOIN animals a ON s.id = a.species_id JOIN visits v ON a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Maisy Smith' GROUP BY s.name ORDER BY COUNT(v.visit_date) DESC LIMIT 1;

explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;
explain analyze SELECT * FROM visits where vet_id = 2 ;
explain analyze SELECT * FROM owners where email = 'owner_18327@mai.com';


