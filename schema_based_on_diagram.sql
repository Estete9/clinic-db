-- HERE ADD YOUR SCHEMAS FOR THE TABLES


-- Add tables according to the diagram provided
CREATE TABLE patients(
  id              INT GENERATED ALWAYS AS IDENTITY,
  name            VARCHAR(100) NOT NULL,
  date_of_birth   DATE NOT NULL,
  PRIMARY KEY(id) 
);

CREATE TABLE medical_histories(
  id              INT GENERATED ALWAYS AS IDENTITY,
  admitted_at     TIMESTAMP NOT NULL,
  patient_id      INT NOT NULL,
  status          VARCHAR(120) NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(patient_id) REFERENCES patients(id)
);

-- Add non-clustered index to medical_histories' FK
CREATE INDEX idx_patient_id ON medical_histories(patient_id);

CREATE TABLE treatments(
  id              INT GENERATED ALWAYS AS IDENTITY,
  type            VARCHAR(120) NOT NULL,
  name            VARCHAR(120) NOT NULL,
  PRIMARY KEY(id) 
);

-- Add a join table to connect medical-histories and treatments as a many-to-many relationship
CREATE TABLE treatment_records(
  id                    INT GENERATED ALWAYS AS IDENTITY,
  treatment_id          INT,
  medical_history_id    INT,
  PRIMARY KEY(id, treatment_id, medical_history_id),
  FOREIGN KEY(treatment_id) REFERENCES treatments(id),
  FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id)
);

-- Add non-clustered index to treatment_records' FKs
CREATE INDEX idx_treatment_id ON treatment_records(treatment_id);
CREATE INDEX idx_medical_history_id ON treatment_records(medical_history_id);

