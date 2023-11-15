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

-- Add an invoice table 
CREATE TABLE invoices(
    id                  INT GENERATED ALWAYS AS IDENTITY,
    total_amount        DECIMAL,
    generated_at        TIMESTAMP NOT NULL,
    payed_at            TIMESTAMP NOT NULL,
    medical_history_id  INT,
    PRIMARY KEY(id, total_amount, generated_at, payed_at, medical_history_id),
    FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id)
)

-- Adds a non-clustered index to invoices' FKs
CREATE INDEX idx_medical_history_id ON invoices(medical_history_id);

-- Add an invoice_items table 
CREATE TABLE invoice_items(
    id                  INT GENERATED ALWAYS AS IDENTITY,
    unit_price          DECIMAL,
    quantity            INT,
    total_price         DECIMAL,
    invoice_id          INT,
    treatment_id        INT,
    PRIMARY KEY(id, unit_price, quantity, total_price, invoice_id, treatment_id),
    FOREIGN KEY(invoice_id) REFERENCES invoices(id),
    FOREIGN KEY(treatment_id) REFERENCES treatments(id)
)
-- Adds a non-clustered index to invoice_items' FKs
CREATE INDEX idx_invoice_id ON invoice_items(invoice_id);
CREATE INDEX idx_treatment_id ON invoice_items(treatment_id);

