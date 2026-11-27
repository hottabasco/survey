--
-- PostgreSQL database dump
--

\restrict vKRxfw8fVka5OjxS5tWirdHkFy4WDJuY6WrNnXjSY2bvwaQ8N8XVfgfu6QlxCFd

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
-- Data for Name: contractor; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contractor (contractor_id, business_name, contact_name, trade, email_address, phone, address, notes, start_date, end_date) FROM stdin;
\.


--
-- Data for Name: survey_data_set; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.survey_data_set (data_set_id, data_set_name, data_set_description, start_date, end_date) FROM stdin;
1	Default Data Set	This is the original Quinquenial report	2026-11-23	\N
2	test data set.	test data set	2026-11-23	\N
\.


--
-- Data for Name: survey_report; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.survey_report (item_id, "Type", "Element Type", "Location", "Description", "Maintenance Required", "Priority", "Tranche", "Notes", data_set_id) FROM stdin;
2.095	LM	Ceiling	Main Meeting House - Entrance Lobby	Plastered and painted.	Generally good.  Undertake cyclical decoration.	\N	Test	\N	2
2.096	LM	Walls	Main Meeting House - Entrance Lobby	Plastered and painted.	Undertake cyclical decoration.  	\N	No action	\N	1
2.129	LM	Sanitary ware	Toilet Accommodation adjacent to Entrance Lobby	MX 3 Sensa Flow hot water boiler.	Fully operational.  	\N	No action	\N	1
2.097	LM	Floor	Main Meeting House - Entrance Lobby	Solid concrete floor with carpet floor covering.  	Undertake clean.  	\N	\N	not correct; timber 	1
2.098	LM	Floor	Main Meeting House - Entrance Lobby	Solid concrete floor with carpet floor covering.  	Consider replacement with new.  	\N	\N	not correct; timber 	1
2.099	LM	Door	Main Meeting House - Entrance Lobby	Timber panelled entranced door with full height locking mechanism and shoot bolts and new Era locking latch.	Breaking down of paint finish.  Redecorate.  	\N	\N	\N	1
2.1	LM	Door	Main Meeting House - Entrance Lobby	Timber panelled entranced door with full height locking mechanism and shoot bolts and new Era locking latch.	Isolated areas of timber decay adjacent to the deadlock.  Undertake repairs. 	\N	No action	\N	1
2.101	LM	Door	Main Meeting House - Entrance Lobby	Timber panelled entranced door with full height locking mechanism and shoot bolts and new Era locking latch.	Missing holder for letterbox.  Replace with new. 	\N	No action	\N	1
2.102	LM	Barrier Matting	Main Meeting House - Entrance Lobby	Walk on barrier matting adjacent to entrance doors. 	Soiled and stained.  Replace with new.  	\N	No action	\N	1
2.103	LM	Entrance Screen	Main Meeting House - Entrance Lobby	Georgian wired timber entrance screen with associated staining; double door set and 2 No. single door sets with lever handle ironmongery; overhead door closers and locking mechanism.  	Generally fair condition.  Allow for cyclical decoration work.  	\N	No action	\N	1
2.104	LM	Windows	Main Meeting House - Entrance Lobby	2 No. single glazed sliding sash units.  	The windows have been painted shut.  Ease; adjust; overhaul and leave fully operational.  	\N	No action	\N	1
2.105	LM	Ceiling	Institute Room	Plastered and papered with a paint finish applied.  	Cracking noted through ceiling surface front to rear.  Cut out and carry out redecoration work.  	\N	No action	\N	1
2.106	LM	Ceiling	Institute Room	Plastered and papered with a paint finish applied.  	Damp staining noted to central ceiling surface.  Thoroughly rub down and redecorate applying stain block as works proceed. 	\N	\N	\N	1
2.107	LM	Walls	Institute Room	Plastered and papered with a paint finish applied.  	Undertake cyclical decoration.  	\N	No action	\N	1
2.108	LM	Windows	Institute Room	Timber single glazed sliding sash windows with timber framed single glazed secondary glazing 	The opening sashes have been painted shut.  Ease; adjust; overhaul and leave fully operational.  	\N	No action	look at ventilation units 	1
2.109	LM	Windows	Institute Room	Timber single glazed sliding sash windows with timber framed single glazed secondary glazing 	Secondary glazing frames catch on frames when operated.  Ease; adjust; overhaul and leave fully operational.  	\N	No action	\N	1
2.11	LM	Floor	Institute Room	Solid concrete floor with laminate floor covering.  	Acceptable condition.  General maintenance only.  	\N	No action	\N	1
2.111	LM	Entrance Door	Institute Room	Six panelled solid core timber entrance door with overhead door closer; digi lock and handle.  	The door catches on the frame when operated.  Ease; adjust; overhaul and leave fully operational.  	\N	\N	plane door	1
2.112	LM	Entrance Door	Institute Room	Six panelled solid core timber entrance door with overhead door closer; digi lock and handle.  	Excessive gap to base of door.  Replace with new in accordance with fire strategy requirements.  	\N	\N	not a fire door	1
2.113	LM	Heating	Institute Room	Wall mounted double panel radiators and gas fire.  	Not tested at the time of inspection.  Ensure adequate test records and certification is in place.  	\N	No action	testing up to date	1
2.114	LM	Ceiling	Library	Plastered and papered with a paint finish applied.  	Cracking noted through ceiling surface front to rear.  Cut out and carry out redecoration work.  	\N	No action	\N	1
2.115	LM	Ceiling	Library	Plastered and papered with a paint finish applied.  	Undertake cyclical decoration.  	\N	No action	\N	1
2.116	LM	Walls	Library	Plastered and papered with a paint finish applied.  	Undertake cyclical decoration.  	\N	No action	\N	1
2.117	LM	Windows	Library	Timber single glazed sliding sash windows with timber framed single glazed secondary glazing 	The opening sashes have been painted shut.  Ease; adjust; overhaul and leave fully operational.  	\N	No action	\N	1
2.118	LM	Windows	Library	Timber single glazed sliding sash windows with timber framed single glazed secondary glazing 	Secondary glazing frames catch on frames when operated.  Ease; adjust; overhaul and leave fully operational.  	\N	No action	\N	1
2.119	LM	Floor	Library	Solid concrete floor with carpet floor covering.  	Acceptable condition.  General maintenance only.  	\N	\N	not correct; timber 	1
2.12	LM	Door	Library, Entrance Door	Six panelled solid core timber entrance door with overhead door closer; digi lock and handle.  	The door catches on the frame when operated.  Ease; adjust; overhaul and leave fully operational.  	\N	No action	\N	1
2.121	LM	Door	Library, Entrance Door	Six panelled solid core timber entrance door with overhead door closer; digi lock and handle.  	Excessive gap to base of door.  Replace with new in accordance with fire strategy requirements.  	\N	\N	not a fire door	1
2.122	LM	Heating	Library	Wall mounted double panel radiators and gas fire.  	Not tested at the time of inspection.  Ensure adequate test records and certification is in place.  	\N	No action	testing up to date	1
2.123	LM	Ceiling	Toilet Accommodation adjacent to Entrance Lobby	Hygienic panelling fitted. 	Good condition; no work required. 	\N	No action	\N	1
2.124	LM	Walls	Toilet Accommodation adjacent to Entrance Lobby	Hygienic panelling fitted. 	Good condition; no work required. 	\N	No action	\N	1
2.125	LM	Floor	Toilet Accommodation adjacent to Entrance Lobby	Safety vinyl floor covering with coved upstand.	Soiled and stained.  Undertake deep clean.  	\N	No action	\N	1
2.126	LM	Floor	Toilet Accommodation adjacent to Entrance Lobby	Safety vinyl floor covering with coved upstand.	Strip out and replace with new.  	\N	No action	\N	1
2.127	LM	Heating	Toilet Accommodation adjacent to Entrance Lobby	Wall mounted radiator to the left hand cubicle with metal grille. 	Corrosion staining noted to grille.  Strip out and replace with new.  	\N	No action	\N	1
2.204	AM	Ceiling	Rear Studio	Plastered and painted. 	Fair condition; allow for cyclical decoration. 	\N	\N	\N	1
2.095	LM	Ceiling	Main Meeting House - Entrance Lobby	Plastered and painted.  	Generally good.  Undertake cyclical decoration. 	f	No action		1
2.128	LM	Sanitary ware	Toilet Accommodation adjacent to Entrance Lobby	Close coupled WCs with associated grab rails; wall mounted wash hand basins with associated mixer tap and disabled WC.	Generally fair but missing indicator cover to the cold tap on the left hand side unit.  Replace with new.  	\N	\N	? - consider further 	1
1	LM	Test	Test Location	Nicks Test Item	None	f	1	Nicks Test Note	1
2.13	LM	Entrance Door	Toilet Accommodation adjacent to Entrance Lobby	Hollow core timber entrance doors with closed fist operation indicator bolts and grab rails and disabled WC.	Fully operational but corrosion staining noted to grab rails.  Replace with new.  	\N	\N	\N	1
2.131	LM	Accessibility	Toilet Accommodation adjacent to Entrance Lobby	Grab rails and associated handle units in the disabled WC.	Consider replacement with new with a more appropriately coloured and contrasting units.  	\N	\N	research needed	1
2.132	LM	Ceiling	Entrance Lobby	Plastered and painted 	Good condition.  Undertake cyclical decoration. 	\N	No action	\N	1
2.133	LM	Walls	Entrance Lobby	Plastered and papered with a paint finish.  	Damage noted to boxing.  Replace. 	\N	No action	\N	1
2.134	LM	Walls	Entrance Lobby	Plastered and papered with a paint finish.  	Breaking down of paint finish.  Undertake cyclical decoration. 	\N	No action	\N	1
2.135	LM	Floor	Entrance Lobby	Solid concrete floor with carpet.  	General wear and staining noted.  Undertake deep clean.  	\N	\N	carpet clean	1
2.136	LM	Floor	Entrance Lobby	Solid concrete floor with carpet.  	Replace carpet with new.  	\N	No action	\N	1
2.137	LM	Entrance Door	Entrance Lobby	Aluminium framed automatic double glazed entrance door.  	Fully operational.  General maintenance only.  	\N	No action	Servicing up to date 	1
2.138	LM	Ceiling	Female WC	Hygienic panelling.  	No work required.  	\N	No action	\N	1
2.139	LM	Walls	Female WC	Plastered and painted.	Generally good condition.  Undertake cyclical decoration work.  	\N	No action	\N	1
2.14	LM	Floor	Female WC	Solid concrete floor with vinyl floor covering.  	Soiled and stained.  Undertake deep clean.  	\N	No action	\N	1
2.141	LM	Floor	Female WC	Solid concrete floor with vinyl floor covering.  	Consider replacement with new.  	\N	No action	\N	1
2.142	LM	Vanity Unit	Female WC	Vanity unit with inset wash hand basins; hot and cold pillar taps; push operated with single tiled splashback.  	Good condition.  Allow for general maintenance only. 	\N	No action	\N	1
2.143	LM	Entrance Door	Female WC	Solid core timber entrance door with overhead door closer; push plate; pull handle and kickplate. 	Fully operational.  General maintenance only.  	\N	No action	\N	1
2.144	LM	Sanitary ware	Female WC	Close coupled WCs with associated laminate finished toilet cubicles.  	Good condition.  Allow for general maintenance only. 	\N	No action	\N	1
2.145	LM	Windows	Female WC	Single glazed aluminium framed units with opening casements and frosted glass.  	Fair condition. 	\N	No action	\N	1
2.146	LM	Windows	Female WC	Single glazed aluminium framed units with opening casements and frosted glass.  	Consider replacement with new double glazed units.  	\N	No action	\N	1
2.147	LM	Ceiling	Meeting Room & Associated Lobby Area	Ceiling tiled finish with surface mounted LED light fittings.  	Breaking down of paint finish.  Undertake cyclical decoration. 	\N	No action	Not sure what this is 	1
2.148	LM	Walls	Meeting Room & Associated Lobby Area	Plastered and painted.	Historic damp staining to the external wall to the left hand side.  Cut out defective plaster and reinstate with new. 	\N	\N	paint only required	1
2.149	LM	Entrance Door	Meeting Room & Associated Lobby Area	Timber paint grade door with one pair hinges; lever handle ironmongery and deadlock.  	The door catches on the frame when operated.  Ease; adjust; overhaul and leave fully operational.  	\N	No action	\N	1
2.15	LM	Windows	Meeting Room & Associated Lobby Area	Timber single glazed casement windows. 	Fair condition.  Fully operational. 	\N	No action	\N	1
2.151	LM	Windows	Meeting Room & Associated Lobby Area	Timber single glazed casement windows. 	Consider replacement with new double glazed units.  	\N	No action	\N	1
2.152	LM	Ceiling	Entrance Lobby	Plastered and painted.  	Good condition.  Undertake cyclical decoration. 	\N	No action	\N	1
2.153	LM	Walls	Entrance Lobby	Plastered and painted.  	Good condition.  Undertake cyclical decoration. 	\N	No action	\N	1
2.154	LM	Floor	Entrance Lobby	Suspended timber floor with carpet finish.  	Soiled and stained with breaking down in various areas.  Undertake deep clean. 	\N	No action	\N	1
2.155	LM	Floor	Entrance Lobby	Suspended timber floor with carpet finish.  	Consider replacement with new.  	\N	No action	\N	1
2.156	LM	Door	Entrance Lobby Main Entrance Area	Double doorset with perspex vision panels.  Six panel units with pull handles; floor mounted door closers and digi lock. 	The doors bind on each other when closed with evidence of previous repairs completed.  Ease; adjust; overhaul doors and leave fully operational. 	\N	\N	\N	1
2.157	LM	Ceiling	Left Hand Side Meeting Room	600 x 1200 ceiling with exposed grid.  	Soiled and stained through use.  Thoroughly clean.  	\N	No action	\N	1
2.158	LM	Ceiling	Left Hand Side Meeting Room	601 x 1200 ceiling with exposed grid.  	Strip out and replace with new.  	\N	No action	\N	1
2.159	LM	Ceiling	Left Hand Side Meeting Room	Plastered ceiling to the left hand side. 	Allow for cyclical decoration.	\N	No action	\N	1
2.16	LM	Walls	Left Hand Side Meeting Room	Plastered and papered with a paint finish applied. 	Good condition.  Allow for cyclical decoration.  	\N	No action	\N	1
2.161	LM	Timber Panelling	Left Hand Side Meeting Room	Decorative timber panelling around the perimeter of the area.  	Minor areas of breaking down of finish; splitting and cracking of joints etc.  Undertake repairs as required and redecorate.  	\N	No action	\N	1
2.162	LM	Floor	Left Hand Side Meeting Room	Suspended timber floor with floorboards with a stained finish.  	Generally sound although some loose floorboards adjacent to the front of the area.  Resecure boards as required.  	\N	No action	\N	1
2.163	LM	Floor	Left Hand Side Meeting Room	Suspended timber floor with floorboards with a stained finish.  	Restain all flooring. 	\N	No action	\N	1
2.164	LM	Door	Left Hand Side Meeting Room Entrance	Double timber doorset with perspex glazed panels; pull handle; push plate; shute bolts and rubber seals.  	The doors bind on each other when operated. Ease; adjust; overhaul and leave fully operational.	\N	No action	\N	1
2.165	LM	Heating	Left Hand Side Meeting Room	4 No. wall mounted double panel radiators with exposed pipework.  	The radiators were not tested at the time of our inspection. 	\N	No action	\N	1
2.166	LM	Windows	Left Hand Side Meeting Room	Single glazed timber sliding sash units with associated ventilation grilles.  	The windows have been painted shut.  Ease; adjust; overhaul and leave fully operational.  	\N	No action	\N	1
2.167	LM	Windows	Left Hand Side Meeting Room	Single glazed timber sliding sash units with associated ventilation grilles.  	Breaking down of paint finish.  Redecorate.  	\N	No action	\N	1
2.168	LM	Door	Door between LHS and RHS Meeting Rooms	Solid core timber paint grade door with one and half pair hinges and push pad escape ironmonery.  	The door catches on the floor slightly when operated.  Ease; adjust; overhaul and leave fully operational.  	\N	No action	\N	1
2.169	LM	Ceiling	Right Hand Side Meeting Room	Tiled finish with 4 No. surface mounted tubular fluorescent fittings.  	Soiled and stained through use.  Thoroughly clean.  	\N	No action	\N	1
2.17	LM	Ceiling	Right Hand Side Meeting Room	Tiled finish with 4 No. surface mounted tubular fluorescent fittings.  	Strip out and replace with new.  	\N	\N	consider professional spray paint	1
2.171	LM	Ceiling	Right Hand Side Meeting Room	Plastered ceiling to the left hand side. 	Allow for cyclical decoration.	\N	No action	\N	1
2.172	LM	Walls	Right Hand Side Meeting Room	Plastered and papered with a paint finish applied. 	Good condition.  Allow for cyclical decoration.  	\N	No action	\N	1
2.173	LM	Timber Panelling	Right Hand Side Meeting Room	Decorative timber panelling around the perimeter of the area.  	Minor areas of breaking down of finish; splitting and cracking of joints etc.  Undertake repairs as required and redecorate.  	\N	\N	budget for full paint 	1
2.174	LM	Floor	Right Hand Side Meeting Room	Suspended timber floor with floorboards with a stained finish.  	Generally sound although some loose floorboards adjacent to the front of the area.  Resecure boards as required.  	\N	\N	? - consider further 	1
2.175	LM	Floor	Right Hand Side Meeting Room	Suspended timber floor with floorboards with a stained finish.  	Restain all flooring. 	\N	No action	\N	1
2.176	LM	Door	Right Hand Side Meeting Room Entrance	Double timber doorset with perspex glazed panels; pull handle; push plate; shute bolts and rubber seals.  	The doors bind on each other when operated. Ease; adjust; overhaul and leave fully operational.	\N	No action	\N	1
2.177	LM	Heating	Right Hand Side Meeting Room	6 No. wall mounted double panel radiators with exposed pipework.  	The radiators were not tested at the time of our inspection. 	\N	No action	\N	1
2.178	LM	Heating	Right Hand Side Meeting Room	6 No. wall mounted double panel radiators with exposed pipework.  	Breaking down of paint finish noted throughout.  Redecorate.  	\N	\N	? - consider further 	1
2.179	LM	Windows	Right Hand Side Meeting Room	Single glazed timber sliding sash units with associated ventilation grilles.  	The windows have been painted shut.  Ease; adjust; overhaul and leave fully operational.  	\N	No action	\N	1
2.18	LM	Windows	Right Hand Side Meeting Room	Single glazed timber sliding sash units with associated ventilation grilles.  	Breaking down of paint finish.  Redecorate.  	\N	No action	\N	1
2.181	LM	Door	Door between LHS and RHS Meeting Rooms	Solid core timber paint grade door with one and half pair hinges and push pad escape ironmongery  	The door catches on the floor slightly when operated; with excessive tension to door closer.  Ease; adjust; overhaul and leave fully operational.  	\N	\N	\N	1
2.182	LM	Ceiling	Store Room	Suspended ceiling tiles with exposed grid.  	Missing tiles and staining present.  Strip out and replace with new.  	\N	No action	\N	1
2.183	LM	Ceiling	Store Room	Plastered and painted soffit above suspended ceiling.  	Evidence of water penetration and flaking paintwork.  Undertake remedial work prior to replacement of ceiling. 	\N	No action	\N	1
2.184	LM	Door	Store Room	Hollow core paint grade door with lever  handle ironmongery and deadlock and one pair hinges.  	The door was fully operational.  Allow for general maintenance.	\N	No action	\N	1
2.185	LM	Floor	Store Room	Suspended timber floor with exposed floorboards. 	Slightly unever in a number of areas.  Relevel floorboards. 	\N	No action	\N	1
2.186	LM	Walls	Store Room	Plastered and painted.  	A full inspection was not possible.  Allow for cyclical decoration.  	\N	No action	\N	1
2.187	LM	Walls	Store Room	Plastered and painted.  	Missing plasterboard lining to internal face of partition wall.  Consider replacement with new.  	\N	No action	\N	1
2.188	LM	Ceiling	Kitchen	Hygienic ceiling tiles with exposed grid.  	Good condition.  No further work required.  	\N	No action	\N	1
2.189	LM	Walls	Kitchen	Plastered and painted.  	Generally good condition with breaking down and staining present.  Allow for cyclical decoration. 	\N	No action	\N	1
2.19	LM	Floor	Kitchen	Suspended timber floor with vinyl flooring.  	Soiled and stained undertake cleaning.  	\N	No action	\N	1
2.191	LM	Kitchen Units	Kitchen	Laminate based worktops and floor mounted door and drawer units.  	Generally good condition and appears to have been relatively recently replaced.  	\N	No action	\N	1
2.192	LM	Kitchen Units	Kitchen	Laminate based worktops and floor mounted door and drawer units.  	Allow for general cleaning of the shelving units to remove all areas of staining as required. 	\N	No action	\N	1
2.193	LM	Entrance Door	Kitchen	Solid core paint grade entrance door with lever handle ironmongery and deadlock; one and half pair hinges. 	Fully operational.  	\N	No action	\N	1
2.195	LM	Roof	Roof void	Timber roof construction; with bitumen based felt liner	Timber decay to ventilated door to flat roof area. Replace with new	\N	\N	Possibly paint. No sign of decay! 	1
2.196	LM	Ceiling	Ceiling Void Area above right meeting room	Plastered soffit and wall surfaces; with insulation above suspended ceiling	Cracking through ceiling surface.  Not priced due uneconomic repairing situation	\N	No action	\N	1
2.197	AM	Ceiling	Artist's Studio	Plastered and painted with coving	Cut out excessive damp staining adjacent to the front coving.  	\N	\N	\N	1
2.198	AM	Sanitary ware	Artist's Studio	Close coupled WC's; urinals; with cubicles and wash hand basins	Overhaul sanitary ware to leave fully operational	\N	\N	\N	1
2.199	AM	Windows	Artist's Studio	Timber framed casements with paint finish	Rear windows have been painted shut. Ease and adjust and leave fully operational	\N	\N	\N	1
2.2	AM	Windows	Artist's Studio	Timber framed sliding sash units with paint finish	Sliding sash windows to rear area have been painted shut with missing sash cords.  	\N	\N	\N	1
2.201	AM	Floor	Artist's Studio	Suspended floor with carpet	Excessivelyt soiled and stained.  Strip out and replace with new	\N	\N	\N	1
2.202	AM	Doors	Artist's Studio	Solid core doors with paint finish	Doors need to be eased and adjusted.  	\N	\N	\N	1
2.205	AM	Walls	Rear Studio	Fair faced brickwork with a paint finish.  	Damp staining at high level adjacent to the flashing detail.  Undertake remedial work to the flashing detail and repoint and clean brickwork.	\N	\N	\N	1
2.206	AM	Walls	Rear Studio	Plasterboard applied to internal face of external walls.  	Scuffed and stained.  Allow for cyclical decoration.  	\N	\N	\N	1
2.207	AM	Walls	Rear Studio	Plasterboard applied to internal face of external walls.  	Evidence of rising dampness to right hand side of rear WC.  Consider new chemically injected damp proof course.	\N	\N	\N	1
2.208	AM	Glazing	Rear Studio	Single glazed timber sliding sash windows. 	1 No. broken pane of glass.  Reglaze.  	\N	\N	\N	1
2.209	AM	Glazing	Rear Studio	Single glazed timber sliding sash windows. 	The windows have been painted shut.  Ease; adjust; overhaul and leave fully operational.  	\N	\N	\N	1
2.21	\N	Sanitary ware	Rear Studio - WC	Close coupled WC with associated seat and lid.  	Acceptable condition but requires cleaning.  	\N	\N	\N	1
2.211	AM	Sink and drainer	Rear Studio - WC	Stainless steel sink and drainers with Red Ring WS7 over sink hot water boiler.  	Soiled and stained.  Undertake deep clean.  	\N	\N	\N	1
2.212	AM	Internal Doors	Rear Studio - WC	Hollow core timber doors with one pair hinges and lever handle ironmongery.  	Loose sections of panelling to doors and doors generally catch on frames when operated.  Ease; adjust; overhaul and leave fully operational.  	\N	\N	\N	1
2.213	AM	Floor	Rear Studio - WC	Solid concrete floor with vinyl floor covering.  	Undertake deep clean.  	\N	\N	\N	1
2.214	AM	Heating	Rear Studio - WC	1 No. wall mounted electric radiator.  	The radiator was not tested at the time of inspection. 	\N	\N	\N	1
2.215	AM	Lighting	Rear Studio - WC	1 No. surface mounted LED fluorescent fitting. 	Fully operational.  	\N	\N	\N	1
2.216	AM	Ceiling	External WC	Plastered and painted.	Damp staining noted to ceiling surface above entrance door.  Hack off defective ceiling plaster and resinstate with new.  Leave ready to receive redecoration.  	\N	\N	\N	1
2.217	AM	Walls	External WC	Plastered and painted.	Excessive damp staining adjacent to the WC.  Corresponding dampness noted externally adjacent to the outside tap.  Hack off wall plaster and reinstate with new.  	\N	\N	\N	1
4.001	LM	Paving Flags	Stone Flagged Paving Area	Stone flagged paving area.  	Generally uneven with moss and vegetation growth noted throughout.  Apply weedkiller and repoint all joints.  	\N	No action	\N	1
4.002	LM	Paving Flags	Stone Flagged Paving Area	Stone flagged paving area.  	Various missing paving flags.  Reinstate with new 	\N	No action	\N	1
4.003	LM	Paving Flags	Stone Flagged Paving Area	Stone flagged paving area.  	Isolated cracked and defective paving flags.  Replace with new. 	\N	No action	\N	1
4.004	LM	Paving Flags	Stone Flagged Paving Area	Stone flagged paving area.  	Paving flags particularly to the right hand side of the rear elevation are particularly uneven.  Consider uplifting and relaying to the entire area.  	\N	\N	Re-position	1
6.001	LM	Roof	Main Hall Roof slopes and rainwater goods	Pitched slated roof slopes above main meeting hall; with associated ridge tiles and stone water tabling.	Replace isolated cracked; cornered and defective slates	\N	\N	\N	1
6.002	LM	Roof	Main Hall Roof slopes and rainwater goods	Pitched slated roof slopes above main meeting hall; with associated ridge tiles and stone water tabling.	Open joints to ridge tiles.  Rake out and replace 	\N	No action	\N	1
6.003	LM	Roof	Main Hall Roof slopes and rainwater goods	Pitched slated roof slopes above main meeting hall; with associated ridge tiles and stone water tabling.	Open joints to stone copings; with temporary repairs completed. Replace defective copings stones with new.	\N	\N	? - consider further 	1
6.004	LM	Roof	Main Hall Roof slopes and rainwater goods	Half round cast iron guttering and associated downpipes.	Corrosion to internal face of guttering. Redecorate and line internal face.	\N	\N	\N	1
6.005	LM	Roof	Roof slopes to Skinnergate elevation	Pitched slated roof slopes with associated parapet guttering and clay ridge tiles	Debris in guttering. Clear	\N	\N	\N	1
6.006	LM	Roof	Roof slopes to Skinnergate elevation	Pitched slated roof slopes with associated parapet guttering and clay ridge tiles	Replace isolated cracked; cornered and defective slates	\N	\N	\N	1
6.007	LM	Roof	Roof slopes to Skinnergate elevation	Pitched slated roof slopes with associated parapet guttering and clay ridge tiles	Open joints to ridge tiles. Rake out and repoint	\N	\N	\N	1
6.008	LM	Roof	Roof slopes to Skinnergate elevation, Chimney Stacks	Brick built chimney stacks with associated clay pots.	Loose lead flashings.  Repair	\N	\N	\N	1
6.009	LM	Roof	Roof slopes to Skinnergate elevation, Chimney Stacks	Brick built chimney stacks with associated clay pots.	Loose cement pointing to haunching to top of stacks.  Cut out and reinstate with new.	\N	\N	\N	1
6.01	LM	Roof	Roof slopes to Skinnergate elevation, Flat roof	Proprietary single ply covering with roof lights	Good Condition	\N	No action	\N	1
6.011	AM	Roof	Roof slopes to Skinnergate elevation, Flat roof	Felt covered section with chippings and rooflights	Strip off and replace with new	\N	\N	\N	1
6.012	AM	Roof	Roof slopes to Skinnergate elevation, Flat roof	Felt covered section with chippings and rooflights	Strip out roof lights and replace with new.	\N	\N	\N	1
6.013	AM	Roof	Flat roof to rear of Area 5	Felt covered section with ventilation flue	Strip and recover	\N	\N	\N	1
6.014	AM	Soffits & Fascias	Skinnergate Elevation - No.4/5	Painted timber soffits and fascias adjacent to rainwater goods.  	Timber decay and breaking down of paint finish noted at high level.  Cut out defective timber work and reinstate with new.	\N	\N	\N	1
6.015	AM	Soffits & Fascias	Skinnergate Elevation - No.4/5	Painted timber soffits and fascias adjacent to rainwater goods.  	Decoration required to the fascia and soffit boards.  Undertake redecoration work.  	\N	\N	\N	1
6.016	AM	Roof Guttering	Skinnergate Elevation - No.4/5	Lead lined parapet gutters and cast iron downpipes	Redecorate downpipes	\N	\N	\N	1
6.017	LM	Roof Guttering	Main Meeting House	Integral gutter detail adjacent to the stone string course and leadlined detail at eaves level discharging into circular cast iron down pipe and associated hopper.	Breaking down of paint finish particularly at base.  Allow for redecoration work.  	\N	No action	\N	1
6.018	LM	Roof Guttering	Main Meeting House	Integral gutter detail adjacent to the stone string course and leadlined detail at eaves level discharging into circular cast iron down pipe and associated hopper.	Consider replacement of downpipe with new.  	\N	\N	D – decorate	1
7.001	LM	Stone Cornice	Main Meeting House	Stone cornice with associated lead cover across the head of the wall at eaves level.  	Evidence of weathering and spalling of the stonework in various area.  Monitor for signs of further disrepair and complete remedial work as required. 	\N	No action	stone stablised at last QQ	1
7.061	AM	Entrance Gate	Rear Yard	Timber framed ledged and braced gate with a paint finish.  	Breaking down of paint finish throughout. Redecorate.  	\N	\N	\N	1
7.002	LM	Stone Cornice	Main Meeting House	Stone cornice with associated lead cover across the head of the wall at eaves level.  	Excessive soiling and staining noted to stonework due to atomospheric polution.  Undertake deep clean and complete remedial work as required.  	\N	No action	\N	1
7.003	LM	Walls	Main Meeting House	Fair faced brickwork laid in a header and stretcher bond pattern.  	Generally good condition with no significant defects noted at the time of inspection.  Monitor for further opening of the mortar joints.  	\N	No action	\N	1
7.004	LM	Walls	Main Meeting House	Fair faced brickwork laid in a header and stretcher bond pattern.  	Stepped cracking above the right hand side ground floor window extending to the underside of the stone string course.  Rake out cracking and repoint.  Allow for replacement of lintel brickwork. 	\N	No action	\N	1
7.005	LM	Stonework	Main Meeting House	Stonework across the base of the wall.  	Weathering noted to individual stone; particularly to the right hand side.  Monitor for signs of further disrepair.  Undertake repairs as required. 	\N	No action	\N	1
7.006	LM	Stonework	Main Meeting House	Stonework across the base of the wall.  	Atmospheric polution and staining noted to stonework.  Thoroughly clean.	\N	No action	\N	1
7.007	LM	Stonework	Main Meeting House	Stonework across the base of the wall.  	Spalling and weathering of brickwork at low level across the base of the stonework; particularly to the right hand side.  Cut out spalled and defective sections of brickwork and replace with new.  	\N	No action	\N	1
7.008	LM	Stonework	Main Meeting House	Stonework across the base of the wall.  	Repointing work undertaken with sand and cement rather than a lime mortar mix.  Rake out defective sections particularly to the left hand side and reinstate with appropriate mix. 	\N	No action	\N	1
7.009	LM	Stone Steps	Main Meeting House	Stone steps to main entrance area.  	Excessive weathering of the top step.  Monitor for signs of further disrepair and undertake refacing cosmestic repairs as required.  	\N	No action	\N	1
7.01	LM	Stone Steps	Main Meeting House	Stone steps to main entrance area.  	Breaking down of bedding detail to the first step from the top landing.  Undertake remedial work to rebed stone and leave in good order. 	\N	\N	? - consider further 	1
7.011	LM	Stone Columns	Main Meeting House	2 No. stone columns adjacent to the front entrance.  	Breaking down of stonework at base.  Undertake refacing work.  	\N	No action	stone stablised at last QQ	1
7.012	LM	Stone Walls	Main Meeting House	Stone walls to entrance lobby area.  	Excessive weathering of the stones to either side of the main entrance doors.  Cut out defective stonework and indent with new.  	\N	No action	\N	1
7.013	LM	Stone Flagged Area	Main Landing Area	Stone flagged covered landing area.  	Uneven surfaces and breaking down of top surface of stonework.  Undertake appropriate remedial repairs to ensure level landing area and to remove trip hazards.  	\N	No action	\N	1
7.014	LM	Stone Flagged Area	Main Landing Area	Stone flagged covered landing area.  	Breaking down of the stone finish to the right hand side of the main entrance adjacent to the railings.  Undertake cosmetic repairs and leave in good order.  	\N	No action	\N	1
7.015	LM	Railings	Main Landing Area	Metal railings with associated paint finish; entrance gates and associated hand rails.  	Allow for cyclical decoration.  	\N	No action	\N	1
7.016	AM	Soffits & Fascias	Friends Community Hub	Painted timber soffits and fascias.	Fair decorative paint finish.  Allow for cyclical decoration. 	\N	No action	\N	1
7.017	AM	Roof Guttering	Friends Community Hub	Ogee section rainwater goods.  	Breaking down of paint finish.  Allow for cyclical decoration	\N	No action	\N	1
7.018	AM	Walls	Friends Community Hub	Painted masonry with decorative stonework also noted.  	Generally fair condition.  Allow for cyclical decoration.  	\N	\N	\N	1
7.019	AM	Windows	Friends Community Hub	Single glazed timber casement windows was noted internally.  	Allow for easing; adjusting and cyclical decoration.  	\N	No action	\N	1
7.02	AM	External Walls	Indulgence Hair & Beauty	External walls with a painted rendered finish.	Generally fair condition.  Allow for cyclical decoration.  	\N	\N	\N	1
7.021	AM	Roof	Indugence Hair & Beauty, Canopy above Shop Front	Felt covered canopy above shop front. 	The felt has reached end of life expectancy.  Strip out and replace with new.  	\N	\N	TCAM	1
7.022	AM	Shop Front	Indugence Hair & Beauty, Shop front	Timber shop front with associated tiled upstand to base.  	Breaking down of paint finish throughout.  Undertake redecoration works. 	\N	\N	TCAM	1
7.023	AM	Shop Front	Indugence Hair & Beauty, Shop front	Timber shop front with associated tiled upstand to base.  	Missing tiles and loose tiles at low level to right hand side.  Strip out and replace with new.  	\N	\N	\N	1
7.024	LM	Walls	Right Elevation to Friends School Yard	External masonry with newly infilled section of modern brickwork in a header and stretcher bond pattern 	Excessive weathering and spalling of masonry. Cut out and replace with new.	\N	\N	\N	1
7.025	LM	Walls	Right Elevation to Friends School Yard	External masonry with newly infilled section of modern brickwork in a header and stretcher bond pattern 	Weathering of brickwork adjacent to Skinnergate at low level.  Cut out defective bricks and replace with new.  	\N	\N	\N	1
7.026	LM	Walls	Right Elevation to Friends School Yard	External masonry with newly infilled section of modern brickwork in a header and stretcher bond pattern 	Isolated open and defective mortar joints.  Rake out and repoint.  	\N	\N	\N	1
7.027	LM	Walls	Right Elevation to Friends School Yard	External masonry with newly infilled section of modern brickwork in a header and stretcher bond pattern 	Historic settlement cracking adjacent to the front beam within the area.  Rake out; repoint and monitor for signs of movement.  	\N	\N	\N	1
7.028	LM	Windows	Right Elevation to Friends School Yard	Timber sliding sash windows with associated metal security grilles.  	The windows have been painted shut but are in fair decorative paint finish.  Allow for cyclical decoration. 	\N	\N	\N	1
7.029	LM	Roof Guttering	Right Elevation to Friends School Yard	Cast iron downpipe with associated hopper.  	Breaking down of paint finish.  Redecorate. 	\N	\N	\N	1
7.03	LM	Asbestos	Right Elevation to Friends School Yard	Assumed asbestos boarding to underside of ceiling surface.  	Undertake testing and confirm accordingly.  	\N	\N	check	1
7.031	LM	Timber Beams	Right Elevation to Friends School Yard	Timber painted beams supporting the roof construction.  	Acceptable condition. 	\N	\N	\N	1
7.032	LM	Timber Beams	Right Elevation to Friends School Yard	Metal plates have been fitted to the timber work  	Evidence of corrosion staining.  Allow for redecoration and rubbing down. 	\N	\N	\N	1
7.062	AM	Entrance Gate	Rear Yard	Timber framed ledged and braced gate with a paint finish.  	Consider replacement with new metal unit.  	\N	\N	\N	1
7.033	LM	Brickwork	Rear Elevation adjacent to Alleyway	Fair faced masonry laid in a header and stretcher bond pattern indicative of a solid wall construction.  	Isolated open mortar joints.  Rake out and repoint.  	\N	\N	\N	1
7.034	LM	Brickwork	Rear Elevation adjacent to Alleyway	Fair faced masonry laid in a header and stretcher bond pattern indicative of a solid wall construction.  	General weathering and spalling of masonry at low level to the left hand side of red fire escape door.  Consider replacement of brickwork in due course.  	\N	\N	\N	1
7.035	LM	Brickwork	Rear Elevation adjacent to Alleyway	Fair faced masonry laid in a header and stretcher bond pattern indicative of a solid wall construction.  	Excessive weathering and staining of masonry adjacent to the external tap.  Thoroughly clean masonry to remove all areas of staining.  Rake out and repoint open and defective mortar joints.  	\N	\N	\N	1
7.036	LM	Brickwork	Rear Elevation adjacent to Alleyway	Fair faced masonry laid in a header and stretcher bond pattern indicative of a solid wall construction.  	Excessive weathering of brickwork at high level to the right handside of the double windows above the mono-pitched roof.  Cut out defective sections of mortar pointing and brickwork and reinstate with new. 	\N	\N	\N	1
7.037	LM	Brickwork	Rear Elevation adjacent to Alleyway	Fair faced masonry laid in a header and stretcher bond pattern indicative of a solid wall construction.  	Investigate potential for corrosion to the security grilles where they bed into the wall and undertake treatment works as required.  	\N	\N	\N	1
7.038	LM	Brickwork	Rear Elevation adjacent to Alleyway	Fair faced masonry laid in a header and stretcher bond pattern indicative of a solid wall construction.  	Excessively weathered brickwork to the brick upstand wall to the right hand side of the mono-pitched roof slope.  Replace defective bricks with new.  	\N	\N	\N	1
7.039	LM	Rendered Finish	Rear Elevation adjacent to Alleyway	Rendered finish to walls to the right hand side of the mono-pitched roof slope and then at high level adjacent to the wardens flat.	Cracked and defective sections of render noted particularly given the damp penetration identified within the rear toilets. Consider hacking off render and reinstate with new.  	\N	\N	\N	1
7.04	LM	Rendered Finish	Rear Elevation adjacent to Alleyway	Rendered finish to walls to the right hand side of the mono-pitched roof slope and then at high level adjacent to the wardens flat.	Breaking down of decorative paint finish to rendered finish.  Consider redecoration work.  	\N	\N	\N	1
7.041	LM	Roof	Warden's Flat Flat Roof	Felt covered flat roof with associated paint finish applied. 	Breaking down of felt finish around perimeter with water penetration noted internally. Strip of and replace with new.	\N	\N	\N	1
7.042	LM	Roof	Warden's Flat Flat Roof	Felt covered flat roof with associated paint finish applied. 	Splitting noted to individual joints to the proprietary covering.  Undertake remedial works in accordance with manufacturer's recommendations.  	\N	\N	\N	1
7.043	LM	Roof	Warden's Flat Flat Roof	Felt covered flat roof with associated paint finish applied. 	Lifting of the proprietary covering around the perimeter of the area particularly adjacent to the guttering.  Readhere and complete repairs in accordance with manufacturer's recommendations.  	\N	\N	\N	1
7.044	LM	Facia Boards	Warden's Flat, Soffit & Fascia adjacent to Warden's Flat	Painted timber soffit and fascia board. 	Redecorate.  	\N	\N	replaced Jan 2026	1
7.045	LM	External metal work	Metal Staircase to rear Studio	Painted metal staircase to rear studio with checker plate treads; etc.  	Breaking down of paint finish.  Redecorate.  	\N	\N	\N	1
7.046	LM	Handrail	Studio	Metal handrail around the perimeter of the area with mesh in place and vertical uprights.	Corrosion staining noted in various area with breaking down of paint finish.  Redecorate. 	\N	\N	\N	1
7.047	LM	Roof	Main Staircase to Flat Roof Area	Steel staircase with a paint finish and associated handrails.  	Breaking down of paint finish noted to the nosing.  Redecorate.  	\N	\N	\N	1
7.048	LM	Roof	Main Staircase to Flat Roof Area	Steel staircase with a paint finish and associated handrails.  	General soiling and staining present.  Thoroughly clean. 	\N	\N	\N	1
7.049	LM	Walls	Right Elevation to Meeting Hall	Fair faced masonry in a header and stretcher bond pattern.  	Generally good condition.  Monitor for signs of further open and defective mortar joints.  	\N	\N	\N	1
7.05	LM	Rendered Finish	Right Elevation to Meeting Hall	Decorated rendered finish to the elevation.  	Generally good condition.  Allow for cyclical decoration of painted element.	\N	\N	\N	1
7.051	LM	Windows	Right Elevation to Meeting Hall	Single glazed timber sliding sash windows which have been painted shut.  	Ease; adjust; overhaul and leave fully operational.  	\N	\N	\N	1
7.052	LM	Windows	Right Elevation to Meeting Hall	Single glazed timber sliding sash windows which have been painted shut.  	Minor shrinkage cracking noted to the cement fillet to either side of the window frames.  Rake out and replace with new.  	\N	\N	\N	1
7.053	LM	Entrance Door to WC	External Elevation to WCs	Timber framed ledged and braced entrance door to WC area.  	Generally good.  Allow for cyclical decoration. 	\N	\N	\N	1
7.054	LM	Soffit & Fascia	External Elevation to WCs	Concrete soffit to underside of roof construction with part paint finish.  	Redecorate. 	\N	\N	\N	1
7.055	LM	Roof Guttering	External Elevation to WCs	Half round plastic gutters discharging into cast iron downpipe.  	Generally good condition.  Allow for cyclical cleaning.  	\N	\N	\N	1
7.056	AM	External elevation	Timber First Floor Extension	Timber first floor extension to rear of Studio with sliding sash single glazed timber windows and a paint finish provided throughout.  	Breaking down of paint finish with evidence of timber decay noted to the panelling to the rear elevation.  Strip out and replace rear timber panelling. 	\N	\N	\N	1
7.057	AM	External elevation	Timber First Floor Extension	Timber first floor extension to rear of Studio with sliding sash single glazed timber windows and a paint finish provided throughout.  	Thoroughly rub down and complete external redecoration works to all areas. 	\N	\N	\N	1
7.058	AM	Boundary Wall	Beauty Studio - Rear Boundary Wall	Fair faced brickwork with associated coping detail to rear of area.  	Damp staining noted around perimeter.  Thoroughly clean masonry and rub down to remove all areas of staining.	\N	\N	\N	1
7.059	AM	Boundary Wall	Beauty Studio - Rear Boundary Wall	Fair faced brickwork with associated coping detail to rear of area.  	Spalled and defective sections of brickwork to the head of wall.  Replace defective bricks with new.  	\N	\N	\N	1
7.06	AM	Wall	Alleyway - Right Elevation	Fair faced masonry laid in a header and stretcher bond pattern indicative of a solid wall construction with a number of openings in filled  	Excessive salt staining and delamination of the external face of the masonry towards the rear of the area.  Cut out defective sections of brickwork and reinstate with new.  	\N	\N	\N	1
7.063	LM	Walls	Rear Elevation to Meeting Hall	Fair faced masonry with a header and stretcher bond pattern with soldier course detail above the rear windows.  	Spalled and defective brickwork above ventilation panel to the roof void.  Replace defective bricks with new.  	\N	\N	\N	1
7.064	LM	Walls	Rear Elevation to Meeting Hall	Fair faced masonry with a header and stretcher bond pattern with soldier course detail above the rear windows.  	Ivy growth noted to elevation.  Remove.  	\N	\N	\N	1
7.065	LM	Walls	Rear Elevation to Meeting Hall	Fair faced masonry with a header and stretcher bond pattern with soldier course detail above the rear windows.  	Isolated areas of open and defective mortar joints to masonry.  Rake out and repoint	\N	\N	\N	1
7.066	LM	Walls	Rear Elevation to Meeting Hall	Fair faced masonry with a header and stretcher bond pattern with soldier course detail above the rear windows.  	Slightly displaced water table to the left hand side roof slope.  Undertake further investigations and secure.  	\N	\N	\N	1
7.067	LM	Walls	Right Elevation to Meeting Hall	Fair faced masonry with a header and stretcher bond pattern with soldier course detail above the rear windows.  	Spalling and weathering noted to the soldier course detail above the windows.  Allow for replacement of defective sections of masonry as required.  	\N	\N	\N	1
7.068	LM	Walls	Right Elevation to Meeting Hall	Fair faced masonry with a header and stretcher bond pattern with soldier course detail above the rear windows.  	Isolated areas of open and defective mortar joints.  Rake out and repoint.	\N	\N	\N	1
7.069	LM	Walls	Right Elevation to Meeting Hall	Fair faced masonry with a header and stretcher bond pattern with soldier course detail above the rear windows.  	Salt staining noted to masonry at low level to the right hand side of the elevation.  Thoroughly clean masonry and replace spalled and defective sections of brickwork.  	\N	\N	\N	1
7.07	LM	Windows	Right Elevation to Meeting Hall	Single glazed timber sliding sash windows. 	The windows have been painted shut.  Ease; adjust; overhaul and leave fully operational.  	\N	\N	\N	1
7.071	LM	Windows	Right Elevation to Meeting Hall - Ground Floor	Single glazed timber sliding sash windows. 	Minor timber decay to to base of right hand side.  Undertake splice repairs and redecorate.  	\N	\N	\N	1
7.072	LM	Doors	Right Elevation to Meeting Hall - Ground Floor	Part wired glazed door set with associated pull handle; 2 No. deadlocks and associated side panels and one and half pair hinges. 	Thoroughly rub down; prepare and decorate.  	\N	\N	\N	1
7.073	LM	Doors	Right Elevation to Meeting Hall - Ground Floor	Part wired glazed doorset with associated pull handle; 2 No. deadlocks and associated side panels and one and half pair hinges. 	Ease; adjust; overhaul and leave fully operational.	\N	\N	\N	1
7.074	LM	Walls	Rear Elevation	Fair faced masonry with a header and stretcher bond pattern with soldier course detail above the rear windows.  	Damp staining running around perimeter of rear elevation and associated left hand side return.  Thoroughly clean masonry to removal all areas of salt staining.  	\N	\N	\N	1
7.075	LM	Walls	Rear Elevation	Fair faced masonry with a header and stretcher bond pattern with soldier course detail above the rear windows.  	Spalled and defective sections of brickwork noted at low level to the left hand side wall.  Cut out defective sections of masonry and reinstate with new. 	\N	\N	\N	1
7.076	LM	Walls	Left Elevation	Fair faced masonry with a header and stretcher bond pattern indicative of a solid wall construction	Good condition with no significant defects noted.	\N	\N	\N	1
7.077	AM	Windows	Left Elevation	Timber single glazed sliding sash windows with a paint finish.  	Undertake redecoration work as required.  	\N	\N	\N	1
7.078	AM	Walls	Left Elevation, Single Storey	Fair faced brickwork laid in a stretcher bond pattern; indicative of cavity wall construction.  	No significant defects noted at the time of the inspection. 	\N	\N	\N	1
7.079	AM	Walls	Rear Elevation to Mono-Pitched Extension.	Fair faced brickwork laid in a stretcher bond pattern with a brick on edge detail above the original section of the masonry.  	Significant movement away from the adjacent boundary wall and associated property.  Cut out cracking; undertake stitch repair work and leave in good order.  	\N	\N	\N	1
7.08	AM	Walls	Rear Elevation to Mono-Pitched Extension.	Fair faced brickwork laid in a stretcher bond pattern with a brick on edge detail above the original section of the masonry.  	Cracked and defective sections of morter joints adjacent to extraction vents.  Rake out and repoint. 	\N	\N	\N	1
8.001	\N	Ceilings	Building wide	Plastered and painted.	Redecorate in line with lifespan expiry.	\N	\N	\N	1
8.002	\N	Walls	Building wide	Plastered and painted.	Redecorate in line with lifespan expiry.	\N	\N	\N	1
8.003	\N	Windows	Building wide	Internal painted timber window frames	Redecorate in line with lifespan expiry.	\N	\N	\N	1
8.004	\N	Doors	Building wide	Painted timber doorsets; being panelled and framed and braced units; with a combination of ironmongery	Redecorate in line with lifespan expiry.	\N	\N	\N	1
8.005	\N	Skirting Board	Building wide, Skirtings and architraves	Painted timber skirting boards	Redecorate in line with lifespan expiry.	\N	\N	\N	1
8.006	\N	Windows	Building wide	External painted timber window frames	Redecorate in line with lifespan expiry.	\N	\N	\N	1
8.007	\N	Doors	Building wide	External painted timber doors and frames	Redecorate in line with lifespan expiry.	\N	\N	\N	1
8.008	\N	Carpet Flooring	Building wide	Eventual reach of end of lifespan.	Replace in line with lifespan expiry.	\N	\N	\N	1
8.009	\N	Vinyl Flooring	Building wide	Eventual reach of end of lifespan.	Replace in line with lifespan expiry.	\N	\N	\N	1
9.001	\N	Electrical	Electrical Supply and Distribution	Incoming electrical supply; with distribution via LV cabling to surface mounted sockets. 	Conduct 5 year fixed wiring testing.  	\N	\N	EICR 2025	1
9.002	\N	Electrical	Electrical Equipment	Various electrical fittings and fixtures throughout the building served from LV supplies. 	Conduct annual PAT testing.  	\N	\N	last test 2024	1
9.003	\N	Electrical	Electrical Equipment	Ongoing service of heating systems 	Gas safe registered engineer to undertake services annually	\N	\N	due May 2026 	1
9.004	\N	Electrical	Electrical Equipment	Various bulkhead emergency light fittings and integral emergency fittings within internal areas; with battery packs. 	Conduct annual emergency light testing.  	\N	\N	tested Jan 2026	1
9.005	\N	Fire Safety Order	Statutory Duties	Fire Risk Assessments	Commission an update/review of the Fire Risk Assessments for the buildings.  	\N	\N	To check	1
9.006	\N	Legionella	Statutory Duties	Entire water and heating systems	Conduct annual legionella testing.	\N	\N	??	1
9.007	\N	Asbestos	Statutory Duties	Control of Asbestos Regulations 2012 duties.  	Provide asbestos register/ undertake asbestos management survey as appropriate to identify all potential ACM's and complete remedial work as required	\N	\N	Asbestos report on file	1
\.


--
-- Data for Name: usr; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.usr (usr_id, account_name, first_name, last_name, role, password, start_date, end_date) FROM stdin;
1	nwilson	Nicholas	Wilson	ADMIN	$2a$10$B9Qk4YY3GP2Vtc1sh/i9w.Lg7gRW41zWcgGTbpaaRIJzMwBYvBbBq	2026-11-21	\N
2	guest	Guest	guest	VIEWER	$2a$10$pjRglVeJAwT73blpbm4aq.97GZQSZJZWn/Z046.AIsYPyWQyUZePi	2026-11-21	\N
\.


--
-- Name: contractor_contractor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.contractor_contractor_id_seq', 1, false);


--
-- Name: survey_data_set_data_set_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.survey_data_set_data_set_id_seq', 2, true);


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

\unrestrict vKRxfw8fVka5OjxS5tWirdHkFy4WDJuY6WrNnXjSY2bvwaQ8N8XVfgfu6QlxCFd

