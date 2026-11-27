--
-- PostgreSQL database dump
--

\restrict j7Nrot7pGgeSpNneWec6P8U75GZCzivusB0P8bhtsjWP4RSvmZe72AUKt9hcQHQ

-- Dumped from database version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: contractor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contractor (
    contractor_id integer NOT NULL,
    business_name character varying(20) NOT NULL,
    contact_name character varying(20),
    trade character varying(20),
    email_address character varying(30),
    phone character varying(20),
    address character varying(80),
    notes text,
    start_date date DEFAULT CURRENT_DATE NOT NULL,
    end_date date
);


--
-- Name: contractor_contractor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contractor_contractor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contractor_contractor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contractor_contractor_id_seq OWNED BY public.contractor.contractor_id;


--
-- Name: survey_data_set; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.survey_data_set (
    data_set_id integer NOT NULL,
    data_set_name character varying(20),
    data_set_description text NOT NULL,
    start_date date DEFAULT CURRENT_DATE NOT NULL,
    end_date date
);


--
-- Name: survey_data_set_data_set_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.survey_data_set_data_set_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: survey_data_set_data_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.survey_data_set_data_set_id_seq OWNED BY public.survey_data_set.data_set_id;


--
-- Name: survey_report; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.survey_report (
    item_id numeric NOT NULL,
    "Type" character varying,
    "Element Type" character varying NOT NULL,
    "Location" character varying NOT NULL,
    "Description" character varying NOT NULL,
    "Maintenance Required" character varying NOT NULL,
    "Priority" boolean,
    "Tranche" character varying,
    "Notes" character varying,
    data_set_id integer NOT NULL
);


--
-- Name: usr; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usr (
    usr_id numeric NOT NULL,
    account_name character varying,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    role character varying NOT NULL,
    password character varying NOT NULL,
    start_date date DEFAULT CURRENT_DATE NOT NULL,
    end_date date
);


--
-- Name: contractor contractor_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contractor ALTER COLUMN contractor_id SET DEFAULT nextval('public.contractor_contractor_id_seq'::regclass);


--
-- Name: survey_data_set data_set_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_data_set ALTER COLUMN data_set_id SET DEFAULT nextval('public.survey_data_set_data_set_id_seq'::regclass);


--
-- Name: contractor contractor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contractor
    ADD CONSTRAINT contractor_pkey PRIMARY KEY (contractor_id);


--
-- Name: survey_data_set survey_data_set_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_data_set
    ADD CONSTRAINT survey_data_set_pkey PRIMARY KEY (data_set_id);


--
-- Name: survey_report survey_report_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_report
    ADD CONSTRAINT survey_report_pkey PRIMARY KEY (data_set_id, item_id);


--
-- Name: usr usr_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usr
    ADD CONSTRAINT usr_pkey PRIMARY KEY (usr_id);


--
-- Name: survey_report survey_report_survey_data_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_report
    ADD CONSTRAINT survey_report_survey_data_set_id_fkey FOREIGN KEY (data_set_id) REFERENCES public.survey_data_set(data_set_id);


--
-- PostgreSQL database dump complete
--

\unrestrict j7Nrot7pGgeSpNneWec6P8U75GZCzivusB0P8bhtsjWP4RSvmZe72AUKt9hcQHQ

