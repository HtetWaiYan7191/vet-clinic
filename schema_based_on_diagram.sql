CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE,
)

CREATE TABLE medical_histories (
    id SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT REFERENCES patients(id),
    status VARCHAR,
)

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    type VARCHAR(255),
    name VARCHAR(255),
)

CREATE TABLE medical_histories_treatments (
    id SERIAL PRIMARY KEY,
    medical_history_id INT,
    treatment_id INT,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
)

CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT REFERENCES medical_histories(id),
)


CREATE TABLE invoice_items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT REFERENCES invoices(id),
    treatment_id INT REFERENCES treatments(id)
)


CREATE INDEX patient_id_idx ON patients(id);
CREATE INDEX medical_history_id_idx ON medical_histories(id);
CREATE INDEX treatment_id_idx ON treatments(id);
CREATE INDEX invoice_id_idx ON invoices(id);
CREATE INDEX invoice_items_id_idx ON invoice_items(id);
CREATE INDEX medical_histories_treatments_id_idx ON medical_histories_treatments(id);
CREATE INDEX medical_history_treatments_medical_history_id_idx ON medical_histories_treatments(medical_history_id)
CREATE INDEX medical_history_treatments_treatments_treatment_id_idx ON medical_histories_treatments(treatment_id)
CREATE INDEX medical_history_id_idx ON medical_histories(patient_id);
