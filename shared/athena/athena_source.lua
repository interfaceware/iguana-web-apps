local AthenaSource = [[{
   "auth" : {
      "oauth" : {
         "access_token_location" : "header",
         "access_token_uri" : "/oauthpreview/token",
         "auth_flows" : [
            "client_cred"
         ],
         "authorize_uri" : "/oauthpreview/token",
         "base_uri" : "https://api.athenahealth.com",
         "options" : {
            "authorize" : {
               "scope" : [
                  "read",
                  "write",
                  "execute"
               ]
            }
         },
         "version" : "2.0"
      }
   },
   "basePath" : "https://api.athenahealth.com",
   "description" : "This API grants access to athenaNet data",
   "name" : "Preview API",
   "protocol" : "rest",
   "resources" : {
     "Administrative" : {
        "methods" : {
           "GET /customfields" : {
              "description" : "Retrieve a list of custom fields for this practice.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/customfields"
           },
           "GET /departments" : {
              "description" : "Get department information",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "providerlist" : {
                    "default" : "false",
                    "description" : "If set to true, list providers who see patients in this department. Default is false.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showalldepartments" : {
                    "default" : "false",
                    "description" : "By default, departments hidden in the portal do not appear. When this is set to true, that restriction is not applied. Default is false.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/departments"
           },
           "GET /departments/{departmentid}" : {
              "description" : "Get department information",
              "httpMethod" : "GET",
              "parameters" : {
                 ":departmentid" : {
                    "default" : null,
                    "description" : "departmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "providerlist" : {
                    "default" : "false",
                    "description" : "If set to true, list providers who see patients in this department. Default is false.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showalldepartments" : {
                    "default" : "false",
                    "description" : "By default, departments hidden in the portal do not appear. When this is set to true, that restriction is not applied. Default is false.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/departments/:departmentid"
           },
           "GET /departments/{departmentid}/checkinrequired" : {
              "description" : "Get required fields for check-in in this department",
              "httpMethod" : "GET",
              "parameters" : {
                 ":departmentid" : {
                    "default" : null,
                    "description" : "departmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/departments/:departmentid/checkinrequired"
           },
           "GET /departments/{departmentid}/ecommunicationdisclosure" : {
              "description" : "Use Accept headers of text/html to get raw HTML.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":departmentid" : {
                    "default" : null,
                    "description" : "departmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/departments/:departmentid/ecommunicationdisclosure"
           },
           "GET /employers" : {
              "description" : "The available list of patient employers. This list is configured by the practice.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "address" : {
                    "default" : "",
                    "description" : "The address of the employer (partial match).",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "city" : {
                    "default" : "",
                    "description" : "The city of the employer (exact match).",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "exactname" : {
                    "default" : "",
                    "description" : "The name of the employer (exact match).",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "name" : {
                    "default" : "",
                    "description" : "The name of the employer (partial match)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "phone" : {
                    "default" : "",
                    "description" : "The phone of the employer (exact match).",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "state" : {
                    "default" : "",
                    "description" : "The state of the employer (exact match).",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "zip" : {
                    "default" : "",
                    "description" : "The zip of the employer (exact match).",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/employers"
           },
           "GET /ethnicities" : {
              "description" : "The list of acceptable ethnicity abbreviations global to athenaNet. The practiceid for this call can be any practice ID that you have access to; the results are global. Consult [ Race and Ethnicity Requirements](https://developer.athenahealth.com/docs/read/workflows/Registration_Race_and_Ethnicity_Requirements) page for a more detailed explanation.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/ethnicities"
           },
           "GET /languages" : {
              "description" : "List of [ISO 639](http://www.loc.gov/standards/iso639-2/php/code_list.php) languages. The practiceid for this call can be any practice ID that you have access to; the results are global.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/languages"
           },
           "GET /misc/patientlocations" : {
              "description" : "The practice-specific list of patient locations (e.g. \"exam room\").",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/misc/patientlocations"
           },
           "GET /misc/smstermsandconditions" : {
              "description" : "Consent text only.  Accept of text/plain is allowed.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/misc/smstermsandconditions"
           },
           "GET /misc/topinsurancepackages" : {
              "description" : "The top athenaNet insurance packages (over .5% utilized, up to 100 packages total) used by the practice.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "Only look at patients who are associated (that is, have their current department set to, or, lacking a current department, have their registration department set to) with this department in determining which insurance packages to list. Note that insurance packages do not \"belong\" to a department and thus department ID is not returned in the output. The same insurance packages will (and often do) appear across multiple departments.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/misc/topinsurancepackages"
           },
           "GET /mobilecarriers" : {
              "description" : "List of mobile carrier ids (standard for all athenaNet).",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/mobilecarriers"
           },
           "GET /ping" : {
              "description" : "Return an acknowledgement that request was received and that this API key has access to the given practice.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/ping"
           },
           "GET /practiceinfo" : {
              "description" : "List of all practice IDs that an API user has access to.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/practiceinfo"
           },
           "GET /providers" : {
              "description" : "Get all providers available for this practice",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "name" : {
                    "default" : "",
                    "description" : "",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "providertype" : {
                    "default" : "",
                    "description" : "",
                    "enum" : [
                       "",
                       "ANP-BC",
                       "APN",
                       "APRN",
                       "ARNP",
                       "AA",
                       "MBBS",
                       "BSW",
                       "BI",
                       "BH",
                       "BCBA",
                       "BCO",
                       "CM",
                       "CAC I",
                       "CAC II",
                       "CAC III",
                       "ANP-C",
                       "ATC",
                       "CCH",
                       "CCCA",
                       "CCP",
                       "CCS",
                       "CDE",
                       "CDMS",
                       "CFA",
                       "CFO",
                       "CLC",
                       "CMA",
                       "CNIM",
                       "CNP",
                       "CNA",
                       "OTC",
                       "COA",
                       "CO",
                       "CPASTC",
                       "CPNP",
                       "CPNP-AC/PC",
                       "PA-C",
                       "CP",
                       "CPO",
                       "CRNA",
                       "CRNP",
                       "CRC",
                       "CSA",
                       "CST",
                       "CLS",
                       "CNS",
                       "PSYD",
                       "EDD",
                       "PSYMA",
                       "PHD",
                       "CSW",
                       "CNA,TECH",
                       "CRNASUP",
                       "CNM",
                       "DMS",
                       "AU.D",
                       "DC",
                       "DMD",
                       "DDS",
                       "ND",
                       "DNP",
                       "DOM",
                       "DO",
                       "DPM",
                       "DPT",
                       "DRIVER",
                       "EI",
                       "EMT",
                       "EMTSUP",
                       "EQUIP",
                       "FNP",
                       "FNP-BC",
                       "FNP-C",
                       "GPT",
                       "ABA-H",
                       "IBCLC",
                       "IOMT",
                       "AP",
                       "LA",
                       "LADAC",
                       "AUD",
                       "LCAS",
                       "LCSW",
                       "LD",
                       "LDO",
                       "LICSW",
                       "LISW",
                       "LMFT",
                       "LMT",
                       "LMSW",
                       "LMHC",
                       "LM",
                       "LP",
                       "LPT",
                       "LPTSUP",
                       "LPTA",
                       "LPN",
                       "LPCC",
                       "LPC",
                       "LPA",
                       "LP-MED",
                       "LSW",
                       "LSAA",
                       "LSA",
                       "LT",
                       "MSPT",
                       "MSN",
                       "MCP",
                       "MPT",
                       "MGC",
                       "MD",
                       "ABA-M",
                       "MS/RD",
                       "MSW",
                       "MA",
                       "NCT",
                       "NP, S",
                       "NP-C",
                       "NUTRSUP",
                       "NP",
                       "NUTR",
                       "OT",
                       "OTA",
                       "OD",
                       "OPA",
                       "PNP-BC",
                       "PHARMD",
                       "OTR",
                       "PT",
                       "PTA",
                       "PASUP",
                       "PMHNP",
                       "PHDH",
                       "PNC",
                       "PA",
                       "RDH",
                       "RDMS",
                       "RD",
                       "RMA",
                       "RNFA",
                       "RRT",
                       "RVT",
                       "RYT",
                       "RES",
                       "RT",
                       "RETAIL",
                       "RN",
                       "SLP",
                       "SLPA",
                       "SRNA",
                       "SPT",
                       "SPTA",
                       "SA",
                       "TECH",
                       "MT",
                       "TRAN",
                       "WHNP-BC",
                       "DTP"
                    ],
                    "enumDescriptions" : [
                       "",
                       "ADULT NURSE PRACTITIONER-BOARD CERTIFIED",
                       "ADVANCED PRACTICE NURSE",
                       "ADVANCED PRACTICE REGISTERED NURSE",
                       "ADVANCED REGISTERED NURSE PRACTITIONER",
                       "ANESTHESIOLOGIST ASSISTANT",
                       "BACHELOR OF MEDICINE AND BACHELOR OF SURGERY",
                       "BACHELOR OF SOCIAL WORK",
                       "BEHAVIOR INTERVENTIONIST",
                       "BEHAVIORAL HEALTH CERTIFICATION",
                       "BOARD CERTIFIED BEHAVIOR ANALYST (BCBA)",
                       "BOARD CERTIFIED OCULARIST",
                       "CASE MANAGER",
                       "CERTIFIED ADDICTION COUNSELOR I",
                       "CERTIFIED ADDICTION COUNSELOR II",
                       "CERTIFIED ADDICTION COUNSELOR III",
                       "CERTIFIED ADULT NURSE PRACTITIONER",
                       "CERTIFIED ATHLETIC TRAINER",
                       "CERTIFIED CLASSICAL HOMEOPATH",
                       "CERTIFIED CLINICAL AUDIOLOGIST",
                       "CERTIFIED CLINICAL PERFUSIONIST",
                       "CERTIFIED CLINICAL SUPERVISOR",
                       "CERTIFIED DIABETIC EDUCATOR",
                       "CERTIFIED DISABILITY CASE MANAGER (CDMS)",
                       "CERTIFIED FIRST ASSISTANT",
                       "CERTIFIED FITTER - ORTHOTICS",
                       "CERTIFIED LACTATION CONSULTANT",
                       "CERTIFIED MEDICAL ASSISTANT",
                       "CERTIFIED NEUROPHYSIOLOGIC INTRAOPERATIVE MONITORING TECHNICIAN",
                       "CERTIFIED NURSE PRACTITIONER",
                       "CERTIFIED NURSING ASSISTANT",
                       "CERTIFIED ORTHOPEDIC TECHNICIAN",
                       "CERTIFIED ORTHOTIC ASSISTANT",
                       "CERTIFIED ORTHOTIST",
                       "CERTIFIED PASTORAL COUNSELOR",
                       "CERTIFIED PEDIATRIC NURSE PRACTITIONER",
                       "CERTIFIED PEDIATRIC NURSE PRACTITIONER: PRIMARY CARE & ACUTE CARE",
                       "CERTIFIED PHYSICIAN'S ASSISTANT",
                       "CERTIFIED PROSTHETIST",
                       "CERTIFIED PROSTHETIST/ORTHOTIST",
                       "CERTIFIED REGISTERED NURSE ANESTHESIOLOGIST",
                       "CERTIFIED REGISTERED NURSE PRACTITIONER",
                       "CERTIFIED REHABILITATION COUNSELOR",
                       "CERTIFIED SURGICAL ASSISTANT",
                       "CERTIFIED SURGICAL TECHNICIAN",
                       "CHILD LIFE SPECIALIST",
                       "CLINICAL NURSE SPECIALIST",
                       "CLINICAL PSYCHOLOGIST",
                       "CLINICAL PSYCHOLOGIST (EDD)",
                       "CLINICAL PSYCHOLOGIST (MA)",
                       "CLINICAL PSYCHOLOGIST (PHD)",
                       "CLINICAL SOCIAL WORKER",
                       "CNA, ALLERGY TECH",
                       "CRNA,SUPERVISING",
                       "Certified Nurse Midwife (CNM)",
                       "DENTIST",
                       "DOCTOR OF AUDIOLOGY",
                       "DOCTOR OF CHIROPRACTIC",
                       "DOCTOR OF DENTAL MEDICINE",
                       "DOCTOR OF DENTAL SURGERY",
                       "DOCTOR OF NATUROPATHY",
                       "DOCTOR OF NURSING PRACTICE",
                       "DOCTOR OF ORIENTAL MEDICINE",
                       "DOCTOR OF OSTEOPATHY (DO)",
                       "DOCTOR OF PODIATRIC MEDICINE",
                       "DOCTORATE OF PHYSICAL THERAPY",
                       "DRIVER",
                       "EARLY INTERVENTIONIST",
                       "EMERGENCY MEDICAL TECHNICIAN",
                       "EMERGENCY MEDICAL TECHNICIAN, SUPERVISING",
                       "EQUIPMENT",
                       "FAMILY NURSE PRACTITIONER",
                       "FAMILY NURSE PRACTITIONER, BOARD CERTIFIED",
                       "FAMILY NURSE PRACTITIONER,CERTIFIED",
                       "GRADUATE OF PHYSICAL THERAPY",
                       "HIGH-LEVEL APPLIED BEHAVIOR ANALYST",
                       "INTERNATIONAL BOARD CERTIFIED LACTATION CONSULTANT",
                       "INTRAOPERATIVE MONITORING TECHNICIAN",
                       "LICENSED ACCUPUNCTURIST",
                       "LICENSED AESTHETICIAN",
                       "LICENSED ALCOHOL AND DRUG ABUSE COUNSELOR",
                       "LICENSED AUDIOLOGIST",
                       "LICENSED CLINICAL ADDICTION SPECIALIST",
                       "LICENSED CLINICAL SOCIAL WORKER (LCSW)",
                       "LICENSED DIETITIAN",
                       "LICENSED DISPENSING OPTICIAN",
                       "LICENSED INDEPENDENT CLINICAL SOCIAL WORKER",
                       "LICENSED INDEPENDENT SOCIAL WORKER",
                       "LICENSED MARRIAGE AND FAMILY THERAPIST",
                       "LICENSED MASSAGE THERAPIST",
                       "LICENSED MASTER SOCIAL WORKER",
                       "LICENSED MENTAL HEALTH COUNSELOR",
                       "LICENSED MIDWIFE",
                       "LICENSED PERFUSIONIST",
                       "LICENSED PHYSICAL THERAPIST (LPT)",
                       "LICENSED PHYSICAL THERAPIST,SUPERVISING",
                       "LICENSED PHYSICAL THERAPY ASSISTANT",
                       "LICENSED PRACTICAL NURSE",
                       "LICENSED PROFESSIONAL CLINIC COUNSELOR",
                       "LICENSED PROFESSIONAL COUNSELOR (LPC)",
                       "LICENSED PSYCHOLOGICAL ASSOCIATE",
                       "LICENSED PSYCHOLOGIST M.ED.",
                       "LICENSED SOCIAL WORKER",
                       "LICENSED SUBSTANCE ABUSE ASSOCIATE",
                       "LICENSED SURGICAL ASSISTANT",
                       "LOCUM TENENS",
                       "MASTER OF SCIENCE OF PHYSICAL THERAPY",
                       "MASTERS NURSING SCIENCE",
                       "MASTERS OF COUNSELING AND PSYCHOLOGY",
                       "MASTERS OF PHYSICAL THERAPY",
                       "MASTERS, GENETIC COUNSELING",
                       "MD",
                       "MID-LEVEL APPLIED BEHAVIOR ANALYST",
                       "MS/RD",
                       "Master Social Worker (MSW)",
                       "Medical Assistant (MA)",
                       "NON-CERTIFIED RADIOLOGY TECHNICIAN",
                       "NURSE PRACTITIONER, SUPERVISING(NP,S)",
                       "NURSE PRACTITIONER-CERTIFIED",
                       "NUTRITIONIST, SUPERVISING",
                       "Nurse Practitioner (NP)",
                       "Nutritionist (NUTR)",
                       "OCCUPATIONAL THERAPIST",
                       "OCCUPATIONAL THERAPIST ASSISTANT",
                       "OPTOMETRIST (OD)",
                       "ORTHOPAEDIC PHYSICIAN ASSISTANT",
                       "PEDIATRIC NURSE PRACTITIONER, BOARD CERTIFIED",
                       "PHARMACIST",
                       "PHYSICAL THERAPIST (OTR)",
                       "PHYSICAL THERAPIST (PT)",
                       "PHYSICAL THERAPY ASSISTANT",
                       "PHYSICIAN'S ASSISTANT, SUPERVISING",
                       "PSYCHIATRIC-MENTAL HEALTH NURSE PRACTITIONER",
                       "PUBLIC HEALTH DENTAL HYGIENIST",
                       "Perinatal Coordinator (PNC)",
                       "Physician's Assistant (PA)",
                       "REGISTERED DENTAL HYGIENIST",
                       "REGISTERED DIAGNOSTIC MEDICAL SONOGRAPHER",
                       "REGISTERED DIETITIAN",
                       "REGISTERED MEDICAL ASSISTANT",
                       "REGISTERED NURSE FIRST ASSISTANT",
                       "REGISTERED RADIOLOGY TECHNICIAN",
                       "REGISTERED VASCULAR TECHNOLOGIST",
                       "REGISTERED YOGA TEACHER",
                       "RESIDENT",
                       "RESPIRATORY THERAPIST",
                       "RETAIL STORE",
                       "Registered Nurse (RN)",
                       "SPEECH AND LANGUAGE PATHOLOGIST",
                       "SPEECH AND LANGUAGE PATHOLOGIST ASSISTANT",
                       "STUDENT NURSE ANESTHETIST",
                       "STUDENT OF PHYSICAL THERAPY",
                       "STUDENT OF PHYSICAL THERAPY (ASSISTANT)",
                       "SURGICAL ASSISTANT",
                       "TECHNICAL",
                       "TRANSCRIPTIONIST",
                       "TRANSPORTATION",
                       "WOMEN'S HEALTH CARE NURSE PRACTITIONER, BOARD CERTIFIED",
                       "ZZ"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showallproviderids" : {
                    "default" : "",
                    "description" : "In athenaNet's internal data structures, a single provider can be represented by multiple IDs. These IDs are used in certain external messages (e.g. HL7) and thus these IDs may need to be known by the API user as well.   When set to true, a list of all of these ancillary IDs will be provided.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showusualdepartmentguessthreshold" : {
                    "default" : "",
                    "description" : "There are situations where determining where a provider \"normally\" practices is desired. Unfortuantely, there is no such concept in athenaNet since providers often practice in multiple locations. However, we can use some intelligence to determine this by looking back over the previous few months (90 days) to see actual practice. To enable this, set this value between 0 and 1; it is highly recommended to be at least .5. This is the ratio of appointments in a given department to the total number of appointments for that provider. A value of .5 means \"the provider's appointments are 50% in the department guessed.\" Setting this to 1 would only return a department if ALL of the provider's appointments were in one department.",
                    "location" : "query",
                    "required" : false,
                    "type" : "number"
                 }
              },
              "path" : "/preview1/:practiceid/providers"
           },
           "GET /providers/{providerid}" : {
              "description" : "Get a single Provider",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":providerid" : {
                    "default" : null,
                    "description" : "providerid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "showallproviderids" : {
                    "default" : "",
                    "description" : "In athenaNet's internal data structures, a single provider can be represented by multiple IDs. These IDs are used in certain external messages (e.g. HL7) and thus these IDs may need to be known by the API user as well.   When set to true, a list of all of these ancillary IDs will be provided.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showusualdepartmentguessthreshold" : {
                    "default" : "",
                    "description" : "There are situations where determining where a provider \"normally\" practices is desired. Unfortuantely, there is no such concept in athenaNet since providers often practice in multiple locations. However, we can use some intelligence to determine this by looking back over the previous few months (90 days) to see actual practice. To enable this, set this value between 0 and 1; it is highly recommended to be at least .5. This is the ratio of appointments in a given department to the total number of appointments for that provider. A value of .5 means \"the provider's appointments are 50% in the department guessed.\" Setting this to 1 would only return a department if ALL of the provider's appointments were in one department.",
                    "location" : "query",
                    "required" : false,
                    "type" : "number"
                 }
              },
              "path" : "/preview1/:practiceid/providers/:providerid"
           },
           "GET /races" : {
              "description" : "The list acceptable race abbreviations. The practiceid for this call can be any practice ID that you have access to; the results are global. Consult [ Race and Ethnicity Requirements](https://developer.athenahealth.com/docs/read/workflows/Registration_Race_and_Ethnicity_Requirements) page for a more detailed explanation.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/races"
           },
           "GET /referralsources" : {
              "description" : "Retrieve a list of referral sources (\"How did you hear about us?\") for this practice.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/referralsources"
           },
           "GET /referringproviders" : {
              "description" : "A list of all providers who refer into this practice.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/referringproviders"
           },
           "GET /slidingfeeplans" : {
              "description" : "Retrieve a list of sliding fee plans for this practice.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/slidingfeeplans"
           },
           "GET /states" : {
              "description" : "List of states (standard for all athenaNet).",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/states"
           },
           "GET /usermessages/{username}" : {
              "description" : "Get the list of messages for the given user and folder.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":username" : {
                    "default" : null,
                    "description" : "username",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "string"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "folder" : {
                    "default" : "",
                    "description" : "Requested message folder. Can be INBOX, SENT, SAVED, TRASH. Defaults to INBOX.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showunreadonly" : {
                    "default" : "",
                    "description" : "Only return unread messages. Defaults to false.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/usermessages/:username"
           },
           "POST /usermessages/{username}" : {
              "description" : "Send a message from the given user to a list of users.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":username" : {
                    "default" : null,
                    "description" : "username",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "string"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "externalid" : {
                    "default" : "",
                    "description" : "String identifier to determine where the message came from.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "message" : {
                    "default" : "",
                    "description" : "The body of this message. Limit of 4000 characters.",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "payload" : {
                    "default" : "",
                    "description" : "String to identify where the message should link to",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "priority" : {
                    "default" : "NORMAL",
                    "description" : "The priority of this message. Can be NORMAL, HIGH, or LOW. Defaults to NORMAL.",
                    "enum" : [
                       "",
                       "HIGH",
                       "LOW",
                       "NORMAL"
                    ],
                    "enumDescriptions" : [
                       "",
                       "HIGH",
                       "LOW",
                       "NORMAL"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "recipientlist" : {
                    "default" : "",
                    "description" : "A comma separated list of users to this this message to.",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "subject" : {
                    "default" : "",
                    "description" : "The subject of this message. Limit of 80 characters.",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/usermessages/:username"
           },
           "PUT /usermessages/{username}/{messageid}" : {
              "description" : "Update the message's read or flagged status.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":messageid" : {
                    "default" : null,
                    "description" : "messageid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":username" : {
                    "default" : null,
                    "description" : "username",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "string"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "flag" : {
                    "default" : "",
                    "description" : "Set whether this message is flagged for followup.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "folder" : {
                    "default" : "",
                    "description" : "Move the message to this folder. Can be INBOX, SENT, SAVED, TRASH.",
                    "enum" : [
                       "",
                       "INBOX",
                       "SAVED",
                       "SENT",
                       "TRASH"
                    ],
                    "enumDescriptions" : [
                       "",
                       "INBOX",
                       "SAVED",
                       "SENT",
                       "TRASH"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "read" : {
                    "default" : "",
                    "description" : "Set whether this message is read.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/usermessages/:username/:messageid"
           },
           "DELETE /usermessages/{username}/{messageid}" : {
              "description" : "Move this message to the TRASH folder. If already in the TRASH folder, permanently deletes this message.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":messageid" : {
                    "default" : null,
                    "description" : "messageid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":username" : {
                    "default" : null,
                    "description" : "username",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "string"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/usermessages/:username/:messageid"
           }
        }
     },
     "Appointments" : {
        "methods" : {
           "GET /appointments/booked" : {
              "description" : "Booked appointment slots",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "appointmenttypeid" : {
                    "default" : "",
                    "description" : "Filter by appointment type ID.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "enddate" : {
                    "default" : "",
                    "description" : "End of the appointment search date range (mm/dd/yyyy).  Inclusive.",
                    "format" : "date",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "endlastmodified" : {
                    "default" : "",
                    "description" : "Identify appointments modified prior to this date/time (mm/dd/yyyy hh:mi:ss).  Inclusive. Note: This can only be used if a startlastmodified value is supplied as well.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "ignorerestrictions" : {
                    "default" : "false",
                    "description" : "When showing patient detail for appointments, the patient information for patients with record restrictions and blocked patients will not be shown.  Setting this flag to true will show that information for those patients.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "patientid" : {
                    "default" : "",
                    "description" : "The athenaNet patient ID.  If operating in a Provider Group Enterprise practice, this should be the enterprise patient ID.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "providerid" : {
                    "default" : "",
                    "description" : "The athenaNet provider ID.  Multiple IDs (either as a comma delimited list or multiple POSTed values) are allowed.",
                    "location" : "query",
                    "required" : false,
                    "type" : "array"
                 },
                 "scheduledenddate" : {
                    "default" : "",
                    "description" : "End of the appointment scheduled search date range (mm/dd/yyyy).  Inclusive.",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "scheduledstartdate" : {
                    "default" : "",
                    "description" : "Start of the appointment scheduled search date range (mm/dd/yyyy).  Inclusive.",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showcancelled" : {
                    "default" : "false",
                    "description" : "Include appointments that have been cancelled.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showclaimdetail" : {
                    "default" : "false",
                    "description" : "Include claim information, if available, associated with an appointment.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showcopay" : {
                    "default" : "true",
                    "description" : "By default, the expected co-pay is returned. For performance purposes, you can set this to false and copay will not be populated.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showinsurance" : {
                    "default" : "false",
                    "description" : "Include patient insurance information. Shows insurance packages for the appointment if any are selected, and all patient packages otherwise.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showpatientdetail" : {
                    "default" : "false",
                    "description" : "Include patient information for each patient associated with an appointment.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "startdate" : {
                    "default" : "",
                    "description" : "Start of the appointment search date range (mm/dd/yyyy).  Inclusive.",
                    "format" : "date",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "startlastmodified" : {
                    "default" : "",
                    "description" : "Identify appointments modified after this date/time (mm/dd/yyyy hh:mi:ss).  Inclusive.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/booked"
           },
           "GET /appointments/booked/multipledepartment" : {
              "description" : "Booked appointment slots",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "appointmenttypeid" : {
                    "default" : "",
                    "description" : "Filter by appointment type ID.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department ID. Multiple IDs (either as a comma delimited list or multiple POSTed values) are allowed.",
                    "location" : "query",
                    "required" : true,
                    "type" : "array"
                 },
                 "enddate" : {
                    "default" : "",
                    "description" : "End of the appointment search date range (mm/dd/yyyy).  Inclusive.",
                    "format" : "date",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "endlastmodified" : {
                    "default" : "",
                    "description" : "Identify appointments modified prior to this date/time (mm/dd/yyyy hh:mi:ss).  Inclusive. Note: This can only be used if a startlastmodified value is supplied as well.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "ignorerestrictions" : {
                    "default" : "false",
                    "description" : "When showing patient detail for appointments, the patient information for patients with record restrictions and blocked patients will not be shown.  Setting this flag to true will show that information for those patients.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "patientid" : {
                    "default" : "",
                    "description" : "The athenaNet patient ID.  If operating in a Provider Group Enterprise practice, this should be the enterprise patient ID.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "providerid" : {
                    "default" : "",
                    "description" : "The athenaNet provider ID.  Multiple IDs (either as a comma delimited list or multiple POSTed values) are allowed.",
                    "location" : "query",
                    "required" : false,
                    "type" : "array"
                 },
                 "scheduledenddate" : {
                    "default" : "",
                    "description" : "End of the appointment scheduled search date range (mm/dd/yyyy).  Inclusive.",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "scheduledstartdate" : {
                    "default" : "",
                    "description" : "Start of the appointment scheduled search date range (mm/dd/yyyy).  Inclusive.",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showcancelled" : {
                    "default" : "false",
                    "description" : "Include appointments that have been cancelled.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showclaimdetail" : {
                    "default" : "false",
                    "description" : "Include claim information, if available, associated with an appointment.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showcopay" : {
                    "default" : "true",
                    "description" : "By default, the expected co-pay is returned. For performance purposes, you can set this to false and copay will not be populated.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showinsurance" : {
                    "default" : "false",
                    "description" : "Include patient insurance information. Shows insurance packages for the appointment if any are selected, and all patient packages otherwise.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showpatientdetail" : {
                    "default" : "false",
                    "description" : "Include patient information for each patient associated with an appointment.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "startdate" : {
                    "default" : "",
                    "description" : "Start of the appointment search date range (mm/dd/yyyy).  Inclusive.",
                    "format" : "date",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "startlastmodified" : {
                    "default" : "",
                    "description" : "Identify appointments modified after this date/time (mm/dd/yyyy hh:mi:ss).  Inclusive.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/booked/multipledepartment"
           },
           "GET /appointments/changed" : {
              "description" : "This API call must be set up in advance by using /appointments/changed/subscription.  It is used to get a set of changes to appointments (generally scheduled, cancelled, check-in), often as a replacement to HL7 SIU messages. The output structure is the same as /appointments/booked. Note that once retrieved, messages are removed from the list. Thus, it is rare that you want to use an offset parameter.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "Department id. Multiple departments are allowed, either comma seperated or with multiple values.",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "ignorerestrictions" : {
                    "default" : "",
                    "description" : "When showing patient detail for appointments, the patient information for patients with record restrictions and blocked patients will not be shown.  Setting this flag to true will show that information for those patients.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "leaveunprocessed" : {
                    "default" : "",
                    "description" : "For testing purposes, do not mark records as processed.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showpatientdetail" : {
                    "default" : "",
                    "description" : "Include patient information for each patient associated with an appointment.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showprocessedenddatetime" : {
                    "default" : "",
                    "description" : "See showprocessestartdatetime.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showprocessedstartdatetime" : {
                    "default" : "",
                    "description" : "Show already processed changes, starting at this mm/dd/yyyy hh24:mi:ss (Eastern) time. Can be used to refetch data if there was an error such as a timeout and records are marked as already retrieved. This is intended to be used with showprocessedenddatetime and for a short period of time only.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/changed"
           },
           "GET /appointments/changed/subscription" : {
              "description" : "Get (GET), set (POST), and remove (DELETE) subscriptions for changed appointments for a given practice. Note that updates take up to 5 minutes (in production, sometimes longer in preview) to take effect and be reflected in a GET. For more information, go to [Changed Data Subscriptions](https://developer.athenahealth.com/docs/read/reference/Changed_Appointments_and_Subscriptions).",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/changed/subscription"
           },
           "POST /appointments/changed/subscription" : {
              "description" : "Get (GET), set (POST), and remove (DELETE) subscriptions for changed appointments for a given practice. Note that updates take up to 5 minutes (in production, sometimes longer in preview) to take effect and be reflected in a GET. For more information, go to [Changed Data Subscriptions](https://developer.athenahealth.com/docs/read/reference/Changed_Appointments_and_Subscriptions).",
              "httpMethod" : "POST",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/changed/subscription"
           },
           "DELETE /appointments/changed/subscription" : {
              "description" : "Get (GET), set (POST), and remove (DELETE) subscriptions for changed appointments for a given practice. Note that updates take up to 5 minutes (in production, sometimes longer in preview) to take effect and be reflected in a GET. For more information, go to [Changed Data Subscriptions](https://developer.athenahealth.com/docs/read/reference/Changed_Appointments_and_Subscriptions).",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/changed/subscription"
           },
           "GET /appointments/open" : {
              "description" : "Open appointment slots within a department, for a given date range",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "appointmenttypeid" : {
                    "default" : "",
                    "description" : "Normally, an appointment reason ID should be used which will map to the correct underlying appointment type in athenaNet. This field will ignore the practice's existing setup for what should be scheduled. Please consult with athenahealth before using. Either an appointmenttypeid or a reasonid must be specified or no results will be returned.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "bypassscheduletimechecks" : {
                    "default" : "",
                    "description" : "Bypass checks that usually require returned appointments to be some amount of hours in the future (as configured by the practice, defaulting to 24 hours), and also ignores the setting that only shows appointments for a certain number of days in the future (also configurable by the practice, defaulting to 90 days).",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "array"
                 },
                 "enddate" : {
                    "default" : "",
                    "description" : "End of the appointment search date range (mm/dd/yyyy).  Inclusive.",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "ignoreschedulablepermission" : {
                    "default" : "false",
                    "description" : "By default, we show only appointments that are are available to scheduled via the API.   This flag allows you to bypass that restriction for viewing available appointments (but you still may not be able to schedule based on this permission!).  This flag does not, however, show the full schedule (that is, appointments that are already booked).",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "providerid" : {
                    "default" : "",
                    "description" : "The athenaNet provider ID. Required if a reasonid other than -1 is specified.",
                    "location" : "query",
                    "required" : false,
                    "type" : "array"
                 },
                 "reasonid" : {
                    "default" : "",
                    "description" : "The athenaNet patient appointment reason ID, from GET /patientappointmentreasons. While this is not technically required due to some unusual use cases, it is highly recommended for most calls. We do allow a special value of -1 for the reasonid. This reasonid will return open, web-schedulable slots regardless of reason.  However, slots returned using a search of -1 may return slots that are not bookable by any reason ID (they may be bookable by specific appointment type IDs instead).  This argument allows multiple valid reason IDs to be specified (e.g. reasonid=1,2,3), so if you are looking for slots that match \"any\" reason, it is recommended that you enumerate the set of reasons you are looking for.  Either a reasonid or an appointmenttypeid must be specified or no results will be returned. If a reasonid other than -1 is specified then a providerid must also be specified.",
                    "location" : "query",
                    "required" : false,
                    "type" : "array"
                 },
                 "showfrozenslots" : {
                    "default" : "false",
                    "description" : "By default, we hide appointments that are frozen from being returned via the API.   This flag allows you to show frozen slots in the set of results returned.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "startdate" : {
                    "default" : "",
                    "description" : "Start of the appointment search date range (mm/dd/yyyy).  Inclusive.  Defaults to today.",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/open"
           },
           "POST /appointments/open" : {
              "description" : "Specifies a provider, department, and date/time for a new appointment slot.  Appointment type or reason can optionally be specified.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "appointmentdate" : {
                    "default" : "",
                    "description" : "The appointment date for the new open appointment slot (mm/dd/yyyy).",
                    "format" : "date",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "appointmenttime" : {
                    "default" : "",
                    "description" : "The time (hh24:mi) for the new appointment slot.  Multiple times (either as a comma delimited list or multiple POSTed values) are allowed.  24 hour time.",
                    "location" : "body",
                    "required" : true,
                    "type" : "array"
                 },
                 "appointmenttypeid" : {
                    "default" : "",
                    "description" : "The appointment type ID to be created.  Either this or a reason must be provided.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department ID.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "providerid" : {
                    "default" : "",
                    "description" : "The athenaNet provider ID.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "reasonid" : {
                    "default" : "",
                    "description" : "The appointment reason (/patientappointmentreasons) to be created. Either this or a raw appointment type ID must be provided.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/open"
           },
           "GET /appointments/report" : {
              "description" : "A report on appointments scheduled by the calling user within a certain date. It will show which appointments created within a certain are currently scheduled, rescheduled, and cancelled.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "enddate" : {
                    "default" : "",
                    "description" : "The ending date range of when an appointment was scheduled (inclusive).",
                    "format" : "date",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "startdate" : {
                    "default" : "",
                    "description" : "The starting date range of when an appointment was scheduled (inclusive).",
                    "format" : "date",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/report"
           },
           "GET /appointments/waitlist" : {
              "description" : "Find entries on the wait list.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The booked appointment ID of the appointment that this wait list entry would replace.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "appointmenttypeid" : {
                    "default" : "",
                    "description" : "The appointment type ID of the desired appointment.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "dayofweekids" : {
                    "default" : "",
                    "description" : "A list (JSON array) of day of week IDs that are desired by the patient, with 1 being Sunday, and 7 being Saturday.",
                    "location" : "query",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID of the desired department.  This can be blank if any department is acceptable.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "hourfrom" : {
                    "default" : "",
                    "description" : "The hour (24 hour clock) after which an appointment is desired by a patient.  Inclusive.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "hourto" : {
                    "default" : "",
                    "description" : "The hour (24 hour clock) before which an appointment is desired by a patient.  Inclusive.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "patientid" : {
                    "default" : "",
                    "description" : "The patient ID of the patient who is on the wait list.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "priority" : {
                    "default" : "",
                    "description" : "One of \"LOW\", \"NORMAL\", or \"HIGH\", indicating the priorty of this wait list entry.",
                    "enum" : [
                       "LOW",
                       "NORMAL",
                       "HIGH"
                    ],
                    "enumDescriptions" : [
                       "LOW",
                       "NORMAL",
                       "HIGH"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "providerid" : {
                    "default" : "",
                    "description" : "The provider ID of the desired provider.  This can be blank if any provider is acceptable.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/waitlist"
           },
           "POST /appointments/waitlist" : {
              "description" : "Adds an entry to the wait list",
              "httpMethod" : "POST",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "allowanydepartment" : {
                    "default" : "",
                    "description" : "While a department is required when creating a wait list entry, this flag indicates that any department is accpetable for an appointment.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The booked appointment ID of the appointment that this wait list entry would replace.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "appointmenttypeid" : {
                    "default" : "",
                    "description" : "The appointment type ID of the desired appointment.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "dayofweekids" : {
                    "default" : "",
                    "description" : "A list (JSON array) of day of week IDs that are desired by the patient, with 1 being Sunday, and 7 being Saturday.",
                    "location" : "body",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID of the desired department.  This can be blank if any department is acceptable.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "hourfrom" : {
                    "default" : "",
                    "description" : "The hour (24 hour clock) after which an appointment is desired by a patient.  Inclusive.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "hourto" : {
                    "default" : "",
                    "description" : "The hour (24 hour clock) before which an appointment is desired by a patient.  Inclusive.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "note" : {
                    "default" : "",
                    "description" : "Practice-facing note about why the wait list entry exists.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "patientid" : {
                    "default" : "",
                    "description" : "The patient ID of the patient who is on the wait list.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "priority" : {
                    "default" : "",
                    "description" : "One of \"LOW\", \"NORMAL\", or \"HIGH\", indicating the priorty of this wait list entry.",
                    "enum" : [
                       "LOW",
                       "NORMAL",
                       "HIGH"
                    ],
                    "enumDescriptions" : [
                       "LOW",
                       "NORMAL",
                       "HIGH"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "providerid" : {
                    "default" : "",
                    "description" : "The provider ID of the desired provider.  This can be blank if any provider is acceptable.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/waitlist"
           },
           "GET /appointments/waitlist/{waitlistid}" : {
              "description" : "Get one entry on the wait list.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":waitlistid" : {
                    "default" : null,
                    "description" : "waitlistid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/waitlist/:waitlistid"
           },
           "PUT /appointments/waitlist/{waitlistid}" : {
              "description" : "Update a wait list entry.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":waitlistid" : {
                    "default" : null,
                    "description" : "waitlistid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "allowanydepartment" : {
                    "default" : "",
                    "description" : "While a department is required when creating a wait list entry, this flag indicates that any department is accpetable for an appointment.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The booked appointment ID of the appointment that this wait list entry would replace.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "appointmenttypeid" : {
                    "default" : "",
                    "description" : "The appointment type ID of the desired appointment.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "dayofweekids" : {
                    "default" : "",
                    "description" : "A list (JSON array) of day of week IDs that are desired by the patient, with 1 being Sunday, and 7 being Saturday.",
                    "location" : "query",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID of the desired department.  This can be blank if any department is acceptable.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "hourfrom" : {
                    "default" : "",
                    "description" : "The hour (24 hour clock) after which an appointment is desired by a patient.  Inclusive.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "hourto" : {
                    "default" : "",
                    "description" : "The hour (24 hour clock) before which an appointment is desired by a patient.  Inclusive.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "note" : {
                    "default" : "",
                    "description" : "Practice-facing note about why the wait list entry exists.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "priority" : {
                    "default" : "",
                    "description" : "One of \"LOW\", \"NORMAL\", or \"HIGH\", indicating the priorty of this wait list entry.",
                    "enum" : [
                       "LOW",
                       "NORMAL",
                       "HIGH"
                    ],
                    "enumDescriptions" : [
                       "LOW",
                       "NORMAL",
                       "HIGH"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "providerid" : {
                    "default" : "",
                    "description" : "The provider ID of the desired provider.  This can be blank if any provider is acceptable.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/waitlist/:waitlistid"
           },
           "DELETE /appointments/waitlist/{waitlistid}" : {
              "description" : "Remove an entry from the wait list.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":waitlistid" : {
                    "default" : null,
                    "description" : "waitlistid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/waitlist/:waitlistid"
           },
           "GET /appointments/{appointmentid}" : {
              "description" : "Retrieve a single appointment, given an appointment ID",
              "httpMethod" : "GET",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "showclaimdetail" : {
                    "default" : "false",
                    "description" : "Include claim information, if available, associated with the appointment.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showinsurance" : {
                    "default" : "false",
                    "description" : "Include patient insurance information.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid"
           },
           "PUT /appointments/{appointmentid}" : {
              "description" : "Books an appointment slot for a specified patient.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "appointmenttypeid" : {
                    "default" : "",
                    "description" : "The appointment type to be booked.  This field should never be used for booking appointments for web-based scheduling.  The use of this field is reserved for digital check-in (aka \"kiosk\") or an application used by practice staff.  One of this or reasonid is required.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "bookingnote" : {
                    "default" : "",
                    "description" : "A note from the patient about why this appointment is being booked",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department ID.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "donotsendconfirmationemail" : {
                    "default" : "",
                    "description" : "For clients with athenaCommunicator, certain appointment types can be configured to have an appointment confirmation email sent to the patient at time of appointment booking. If this parameter is set to true, that email will not be sent.  This should only be used if you plan on sending a confirmation email via another method.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "ignoreschedulablepermission" : {
                    "default" : "false",
                    "description" : "By default, we allow booking of appointments marked as schedulable via the web.  This flag allows you to bypass that restriction for booking.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancecompany" : {
                    "default" : "",
                    "description" : "The name of the insurance company.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancegroupid" : {
                    "default" : "",
                    "description" : "If available, any identifier for the insurance group.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insuranceidnumber" : {
                    "default" : "",
                    "description" : "The insurance identifier for this individual patient.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancenote" : {
                    "default" : "",
                    "description" : "Any extra information provided by the patient about insurance coverage.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancephone" : {
                    "default" : "",
                    "description" : "The phone number for the insurance company.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insuranceplanname" : {
                    "default" : "",
                    "description" : "The insurance plan name (e.g. \"HMO Blue\").",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholder" : {
                    "default" : "",
                    "description" : "The full name of the insurance policy holder.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "nopatientcase" : {
                    "default" : "",
                    "description" : "By default, we create a patient case upon booking an appointment for new patients.  Setting this to true bypasses that patient case.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "patientid" : {
                    "default" : "",
                    "description" : "The athenaNet patient ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "patientrelationshiptopolicyholder" : {
                    "default" : "",
                    "description" : "A textual description of the patient's relationship to the policyholder.  Recommended: Self, Parent, Spouse, Child, Other.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "reasonid" : {
                    "default" : "",
                    "description" : "The appointment reason ID to be booked.  This field is required for booking appointments for web-based scheduling and is a reason that is retrieved from the /patientappointmentreasons call.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid"
           },
           "DELETE /appointments/{appointmentid}" : {
              "description" : "Deletes an open appointment. Only open appointments can be deleted. See full documentation here: [Appointments](https://developer.athenahealth.com/docs/read/appointments/Appointments).",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid"
           },
           "PUT /appointments/{appointmentid}/cancel" : {
              "description" : "Cancels a scheduled appointment",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "cancellationreason" : {
                    "default" : "",
                    "description" : "A text explanation why the appointment is being cancelled",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "ignoreschedulablepermission" : {
                    "default" : "false",
                    "description" : "By default, we allow booking of appointments marked as schedulable via the web.  This flag allows you to bypass that restriction for booking.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "nopatientcase" : {
                    "default" : "",
                    "description" : "By default, we create a patient case upon booking an appointment for new patients.  Setting this to true bypasses that patient case.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "patientid" : {
                    "default" : "",
                    "description" : "The athenaNet patient ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/cancel"
           },
           "GET /appointments/{appointmentid}/checkin" : {
              "description" : "Returns the list of conditions required before check-in.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/checkin"
           },
           "POST /appointments/{appointmentid}/checkin" : {
              "description" : "Check in this appointment.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/checkin"
           },
           "PUT /appointments/{appointmentid}/freeze" : {
              "description" : "Freezes/Unfreezes an appointment",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "freeze" : {
                    "default" : "",
                    "description" : "If true, slot will be frozen, if false, slot will be unfrozen",
                    "enum" : [
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/freeze"
           },
           "GET /appointments/{appointmentid}/mspq" : {
              "description" : "Set the Medicare Secondary Payer (MSP) qualifier",
              "httpMethod" : "GET",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/mspq"
           },
           "PUT /appointments/{appointmentid}/mspq" : {
              "description" : "Set the Medicare Secondary Payer (MSP) qualifier",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "mspinsurancetypeid" : {
                    "default" : "",
                    "description" : "The MSP insurance type id",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "mspinsurancetypesetyn" : {
                    "default" : "",
                    "description" : "Set the MSP Insurance Type",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "patientid" : {
                    "default" : "",
                    "description" : "The athenaNet patient ID.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/mspq"
           },
           "DELETE /appointments/{appointmentid}/mspq" : {
              "description" : "Set the Medicare Secondary Payer (MSP) qualifier",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/mspq"
           },
           "GET /appointments/{appointmentid}/notes" : {
              "description" : "Retrieve notes for this appointment.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, we prevent deleted appointment notes from being returned via the API.   This flag allows you to show deleted notes in the set of results returned.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/notes"
           },
           "POST /appointments/{appointmentid}/notes" : {
              "description" : "Add a note for an appointment.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "notetext" : {
                    "default" : "",
                    "description" : "The note text.",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/notes"
           },
           "PUT /appointments/{appointmentid}/notes/{noteid}" : {
              "description" : "Update the note text for an appointment note.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":noteid" : {
                    "default" : null,
                    "description" : "noteid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "notetext" : {
                    "default" : "",
                    "description" : "The note text.",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/notes/:noteid"
           },
           "DELETE /appointments/{appointmentid}/notes/{noteid}" : {
              "description" : "Delete a note for an appointment.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":noteid" : {
                    "default" : null,
                    "description" : "noteid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/notes/:noteid"
           },
           "PUT /appointments/{appointmentid}/reschedule" : {
              "description" : "Reschedules a scheduled appointment",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "ignoreschedulablepermission" : {
                    "default" : "false",
                    "description" : "By default, we allow booking of appointments marked as schedulable via the web.  This flag allows you to bypass that restriction for booking.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "newappointmentid" : {
                    "default" : "",
                    "description" : "The appointment ID of the new appointment.   (The appointment ID in the URL is the ID of the currently scheduled appointment.)",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "nopatientcase" : {
                    "default" : "",
                    "description" : "By default, we create a patient case upon booking an appointment for new patients.  Setting this to true bypasses that patient case.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "patientid" : {
                    "default" : "",
                    "description" : "The athenaNet patient ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "reasonid" : {
                    "default" : "",
                    "description" : "The appointment reason ID to be booked. If not provided, the same reason used in the original appointment will be used. Note: when getting open appointment slots, a special reason of -1 will return appointment slots for any reason.  This is not recommended, however, because actual availability does depend on a real reason.  In addition, appointment availability when using -1 does not account for the ability to not allow appointments to be scheduled too close to the current time (because that limit is set on a per appointment reason basis).",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "reschedulereason" : {
                    "default" : "",
                    "description" : "A text explanation why the appointment is being rescheduled",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/reschedule"
           },
           "POST /appointments/{appointmentid}/startcheckin" : {
              "description" : "Note that the check-in process has started.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/startcheckin"
           },
           "GET /appointments/{appointmentid}/thirdpartycodingstatus" : {
              "description" : "Gets an appointment's coding status(es)",
              "httpMethod" : "GET",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/thirdpartycodingstatus"
           },
           "POST /appointments/{appointmentid}/thirdpartycodingstatus" : {
              "description" : "Updates an appointment's coding status",
              "httpMethod" : "POST",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "status" : {
                    "default" : "",
                    "description" : "The status to set this appointment's third party coding status to.",
                    "enum" : [
                       "STARTED"
                    ],
                    "enumDescriptions" : [
                       "Work has been started"
                    ],
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/thirdpartycodingstatus"
           },
           "PUT /appointments/{appointmentid}/thirdpartycodingstatus" : {
              "description" : "Updates an appointment's coding status",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "status" : {
                    "default" : "",
                    "description" : "The status to set this appointment's third party coding status to.",
                    "enum" : [
                       "STARTED"
                    ],
                    "enumDescriptions" : [
                       "Work has been started"
                    ],
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/thirdpartycodingstatus"
           },
           "DELETE /appointments/{appointmentid}/thirdpartycodingstatus" : {
              "description" : "Removes an appointment's coding status.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/thirdpartycodingstatus"
           },
           "GET /appointments/{appointmentid}/thirdpartyexternaldata" : {
              "description" : "Gets an appointment's external data",
              "httpMethod" : "GET",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/thirdpartyexternaldata"
           },
           "POST /appointments/{appointmentid}/thirdpartyexternaldata" : {
              "description" : "Updates an appointment's external data value",
              "httpMethod" : "POST",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "externaldata" : {
                    "default" : "",
                    "description" : "The external data to be stored for this, up to 4000 characters",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/thirdpartyexternaldata"
           },
           "PUT /appointments/{appointmentid}/thirdpartyexternaldata" : {
              "description" : "Updates an appointment's external data value",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "externaldata" : {
                    "default" : "",
                    "description" : "The external data to be stored for this, up to 4000 characters",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/thirdpartyexternaldata"
           },
           "DELETE /appointments/{appointmentid}/thirdpartyexternaldata" : {
              "description" : "Removes an appointment's external data.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/thirdpartyexternaldata"
           },
           "GET /appointmenttypes" : {
              "description" : "Raw appointment types for this practice.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "hidegeneric" : {
                    "default" : "false",
                    "description" : "By default, we show both generic and non-generic types. Setting this to true will hide the generic types (and show only non-generic types).",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "hidenongeneric" : {
                    "default" : "false",
                    "description" : "By default, we show both generic and non-generic types. Setting this to true will hide non-generic types (and show only generic types).",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "hidenonpatient" : {
                    "default" : "true",
                    "description" : "This defaults to true if not specified, and thus will hide non-patient facing types.  Setting this to false would thus show non-patient facing types.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "hidetemplatetypeonly" : {
                    "default" : "false",
                    "description" : "By default, we show both \"template only\" and not-template only types. Setting this to true, the results will omit template only types. (\"Template only\" is a setting that makes the type appear in schedules, but forces users to select a non-template type upon booking.)",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/appointmenttypes"
           },
           "POST /appointmenttypes" : {
              "description" : "Adds an appointment type",
              "httpMethod" : "POST",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "duration" : {
                    "default" : "",
                    "description" : "The expected duration, in minutes, of the appointment type.  Note, this value cannot be changed after creation, so please choose carefully.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "generic" : {
                    "default" : "",
                    "description" : "If set to true, this type serves as a \"generic\" type, that will match any type when searching.  Defaults to false.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "name" : {
                    "default" : "",
                    "description" : "The name of the appointment type.  Maximum length of 30 characters.",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "patient" : {
                    "default" : "",
                    "description" : "If set to true, this type serves as a \"patient\" type, meaning that is is a type that can be used for booking patients. If set to false, then it this type will not be used for patient (e.g. \"Lunch\" or \"Vacation\").  Non-patient types are mostly used to reserving time for providers to not see patients.",
                    "enum" : [
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "shortname" : {
                    "default" : "",
                    "description" : "The short name code of the appointment type.  Maximum length of 4 characters. Used for making schedule templates.  Note, this value cannot be changed after creation, so please choose carefully.",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "templatetypeonly" : {
                    "default" : "",
                    "description" : "If set to true, this type serves as a \"template-only\" type, meaning that it can be used for building schedule templates, but cannot be used for booking appointments (i.e. another type must be chosen). Defaults to false.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointmenttypes"
           },
           "GET /appointmenttypes/{appointmenttypeid}" : {
              "description" : "Get one appointment type.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":appointmenttypeid" : {
                    "default" : null,
                    "description" : "appointmenttypeid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointmenttypes/:appointmenttypeid"
           },
           "PUT /appointmenttypes/{appointmenttypeid}" : {
              "description" : "Update a appointment type entry.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":appointmenttypeid" : {
                    "default" : null,
                    "description" : "appointmenttypeid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "generic" : {
                    "default" : "",
                    "description" : "If set to true, this type serves as a \"generic\" type, that will match any type when searching.  Defaults to false.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "name" : {
                    "default" : "",
                    "description" : "The name of the appointment type.  Maximum length of 30 characters.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "patient" : {
                    "default" : "",
                    "description" : "If set to true, this type serves as a \"patient\" type, meaning that is is a type that can be used for booking patients. If set to false, then it this type will not be used for patient (e.g. \"Lunch\" or \"Vacation\").  Non-patient types are mostly used to reserving time for providers to not see patients.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "templatetypeonly" : {
                    "default" : "",
                    "description" : "If set to true, this type serves as a \"template-only\" type, meaning that it can be used for building schedule templates, but cannot be used for booking appointments (i.e. another type must be chosen). Defaults to false.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointmenttypes/:appointmenttypeid"
           },
           "GET /mspinsurancetypes" : {
              "description" : "Get list of valid MSP insurance types",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department id",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 100, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/mspinsurancetypes"
           },
           "GET /patientappointmentreasons" : {
              "description" : "Appointment reasons available for patients.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "providerid" : {
                    "default" : "",
                    "description" : "The athenaNet provider ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patientappointmentreasons"
           },
           "GET /patientappointmentreasons/existingpatient" : {
              "description" : "Appointment reasons available for patients.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "providerid" : {
                    "default" : "",
                    "description" : "The athenaNet provider ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patientappointmentreasons/existingpatient"
           },
           "GET /patientappointmentreasons/newpatient" : {
              "description" : "Appointment reasons available for patients.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "providerid" : {
                    "default" : "",
                    "description" : "The athenaNet provider ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patientappointmentreasons/newpatient"
           }
        }
     },
     "Chart" : {
        "methods" : {
           "GET /chart/configuration/medicalhistory" : {
              "description" : "QuestionSet for this chart",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "",
                    "description" : "Include deleted questions",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/configuration/medicalhistory"
           },
           "GET /chart/configuration/obgynhistory" : {
              "description" : "QuestionSet for this chart",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "",
                    "description" : "Include deleted questions",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/configuration/obgynhistory"
           },
           "GET /chart/configuration/socialhistory" : {
              "description" : "List of configured social history templates and questions for this practice. A question (identified by KEY) can exist in more than one template and is distinguished by QUESTIONID, although the answers are linked. See the reference documentation for [Social History](https://developer.athenahealth.com/docs/read/chart/Social_History_Overview).",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/chart/configuration/socialhistory"
           },
           "GET /chart/configuration/vitals" : {
              "description" : "List of configured vitals for this practice",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showunconfigured" : {
                    "default" : "",
                    "description" : "Show all global vitals, even if they are not configured at this practice.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "specialtyid" : {
                    "default" : "",
                    "description" : "Show only the vitals configured for this specialty",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/configuration/vitals"
           },
           "GET /chart/{patientid}/allergies" : {
              "description" : "Returns the list of allergies for this patient.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "showinactive" : {
                    "default" : "",
                    "description" : "Include deactivated allergies",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/allergies"
           },
           "PUT /chart/{patientid}/allergies" : {
              "description" : "Patient allergies and associated information.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "allergies" : {
                    "default" : "",
                    "description" : "A complex JSON object containing an update to the list of patient allergies. Any new allergies will be added, and any existing ones (based on allergenid) will be updated. If any existing ones are skipped, they will NOT be deleted. As such, this section can be empty if, for example, you just want to update NKDA status or the section note.",
                    "location" : "query",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department for this patient. A patient may have multiple charts, and the department determines which chart to retrieve.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "nkda" : {
                    "default" : "",
                    "description" : "Whether the patient has no known drug allergies. This is an explicit statement separate from a patient with no documented allergies so far. Note that while a patient can have this checked and have allergies, that is not recommended.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "sectionnote" : {
                    "default" : "",
                    "description" : "A section-wide note. Passing an empty string will remove any existing note.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/allergies"
           },
           "GET /chart/{patientid}/analytes" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/analytes"
           },
           "GET /chart/{patientid}/careteam" : {
              "description" : "Retrieve the care team for a patient/chart",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/careteam"
           },
           "GET /chart/{patientid}/clinicalproviders/default" : {
              "description" : "Preferred clinical providers for this chart",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "clinicalordertypegroupid" : {
                    "default" : "",
                    "description" : "The clinical order type group id (Prescription: 10, Lab: 11, Vaccine: 16)",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/clinicalproviders/default"
           },
           "PUT /chart/{patientid}/clinicalproviders/default" : {
              "description" : "Update preferred clinical providers for this chart",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "clinicalordertypegroupid" : {
                    "default" : "",
                    "description" : "The clinical order type group id (Prescription: 10, Lab: 11, Vaccine: 16).",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "ncpdpid" : {
                    "default" : "",
                    "description" : "The NCPDP id of the provider.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/clinicalproviders/default"
           },
           "GET /chart/{patientid}/clinicalproviders/preferred" : {
              "description" : "Preferred clinical providers for this chart",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "clinicalordertypegroupid" : {
                    "default" : "",
                    "description" : "The clinical order type group id (Prescription: 10, Lab: 11, Vaccine: 16)",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 100, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/clinicalproviders/preferred"
           },
           "PUT /chart/{patientid}/clinicalproviders/preferred" : {
              "description" : "Update preferred clinical providers for this chart",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "clinicalordertypegroupid" : {
                    "default" : "",
                    "description" : "The clinical order type group id (Prescription: 10, Lab: 11, Vaccine: 16).",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "ncpdpid" : {
                    "default" : "",
                    "description" : "The NCPDP id of the provider.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/clinicalproviders/preferred"
           },
           "DELETE /chart/{patientid}/clinicalproviders/preferred" : {
              "description" : "Update preferred clinical providers for this chart",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "clinicalordertypegroupid" : {
                    "default" : "",
                    "description" : "The clinical order type group id (Prescription: 10, Lab: 11, Vaccine: 16).",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "ncpdpid" : {
                    "default" : "",
                    "description" : "The NCPDP id of the provider.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/clinicalproviders/preferred"
           },
           "POST /chart/{patientid}/documentexport" : {
              "description" : "Create a chart export (patient record) in athenaNet",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "createfromdatedocumentclass" : {
                    "default" : "",
                    "description" : "One or more document classes to include in the export.  Defaults to LABRESULT, IMAGINGRESULT, and CLINICALDOCUMENT.",
                    "enum" : [
                       "ADMIN",
                       "CLINICALDOCUMENT",
                       "ENCOUNTERDOCUMENT",
                       "DME",
                       "IMAGINGRESULT",
                       "LABRESULT",
                       "LETTER",
                       "MEDICALRECORD",
                       "ORDER",
                       "PATIENTCASE",
                       "PHONEMESSAGE",
                       "PHYSICIANAUTH",
                       "PRESCRIPTION",
                       "SURGERY",
                       "VACCINE"
                    ],
                    "enumDescriptions" : [
                       "Admin Document",
                       "Clinical Document",
                       "Encounter Document",
                       "Durable Medical Equipment",
                       "Imaging/Diagnostic Result",
                       "Lab Result",
                       "Letter",
                       "Medical Record Document",
                       "Order",
                       "Patient Case",
                       "Phone Message",
                       "Physician Authorization",
                       "Prescription",
                       "Surgical Order",
                       "Vaccine"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "array"
                 },
                 "createfromdaterangeend" : {
                    "default" : "",
                    "description" : "The end date, inclusive, of the chart export.  Defaults to today.",
                    "format" : "date",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "createfromdaterangestart" : {
                    "default" : "",
                    "description" : "The start date, inclusive, of the chart export.",
                    "format" : "date",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID associated with the document export.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/documentexport"
           },
           "GET /chart/{patientid}/documentexport/{documentid}" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":documentid" : {
                    "default" : null,
                    "description" : "documentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/documentexport/:documentid"
           },
           "GET /chart/{patientid}/encounters" : {
              "description" : "Encounters that have occured in the past for this chart",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "Find the encounter for this appointment.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "enddate" : {
                    "default" : "",
                    "description" : "Omit any encounters later than this date",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showallstatuses" : {
                    "default" : "",
                    "description" : "By default only encounters in OPEN, CLOSED, or REVIEW status are retrieved, with this flag, encounters aren't filtered by status.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showalltypes" : {
                    "default" : "",
                    "description" : "Retrieve all encounter types, by default only VISIT and ORDERSONLY are retrieved.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showdiagnoses" : {
                    "default" : "",
                    "description" : "Query diagnosis information for every encounter",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "startdate" : {
                    "default" : "",
                    "description" : "Omit any encounters earlier than this date",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/encounters"
           },
           "GET /chart/{patientid}/encounters/{appointmentid}/summary" : {
              "description" : "The HTML Summary for an encounter wrapped in JSON. Use an accept header of text/html or application/pdf to get a non-JSON encoded version.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "mobile" : {
                    "default" : "",
                    "description" : "Flag to skip many details to make the html smaller",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "skipamendments" : {
                    "default" : "",
                    "description" : "Flag to skip encounter amendments",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/encounters/:appointmentid/summary"
           },
           "GET /chart/{patientid}/familyhistory" : {
              "description" : "FamilyHistory for this chart",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/familyhistory"
           },
           "PUT /chart/{patientid}/familyhistory" : {
              "description" : "FamilyHistory for this chart",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "relatives" : {
                    "default" : "",
                    "description" : "A JSON array of relatives, mimicking [the output format](https://developer.athenahealth.com//docs/chart/List_or_Update_Family_History_Problems) of the GET call.",
                    "location" : "query",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "sectionnote" : {
                    "default" : "",
                    "description" : "Any additional section notes",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/familyhistory"
           },
           "GET /chart/{patientid}/interpretations" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/interpretations"
           },
           "GET /chart/{patientid}/labresults" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/labresults"
           },
           "GET /chart/{patientid}/medicalhistory" : {
              "description" : "MedicalHistory for this chart",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/medicalhistory"
           },
           "PUT /chart/{patientid}/medicalhistory" : {
              "description" : "MedicalHistory for this chart",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "questions" : {
                    "default" : "",
                    "description" : "A complex JSON object containing the patient medical history. See the Chart documentation for more details.",
                    "location" : "query",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "sectionnote" : {
                    "default" : "",
                    "description" : "Any additional section notes",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/medicalhistory"
           },
           "GET /chart/{patientid}/medications" : {
              "description" : "Get the list of medications for given patient.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenanet department ID",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "showndc" : {
                    "default" : "",
                    "description" : "Shows the list of NDC numbers related to the medication.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showrxnorm" : {
                    "default" : "",
                    "description" : "Shows the list of RxNorm Identifiers related to the medication. The list may contain both branded and generic identifiers.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/medications"
           },
           "POST /chart/{patientid}/medications" : {
              "description" : "Add a new historical medication.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenanet department ID",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "hidden" : {
                    "default" : "",
                    "description" : "Set whether the medication is hidden in the UI.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "medicationid" : {
                    "default" : "",
                    "description" : "The athena medication ID",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "patientnote" : {
                    "default" : "",
                    "description" : "A patient-facing note",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "providernote" : {
                    "default" : "",
                    "description" : "An internal note",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "startdate" : {
                    "default" : "",
                    "description" : "Start date for this medication",
                    "format" : "date",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "stopdate" : {
                    "default" : "",
                    "description" : "Stop date for this medication",
                    "format" : "date",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "stopreason" : {
                    "default" : "",
                    "description" : "The reason the medication was stopped. If set, it it recommended but not required that a stop date is also set.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "unstructuredsig" : {
                    "default" : "",
                    "description" : "Can only be used to update historical (entered, downloaded, etc) medications. Will override a structured sig if there is one.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/medications"
           },
           "PUT /chart/{patientid}/medications" : {
              "description" : "Update the section wide note and no medications reported flag.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenanet department ID",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "nomedicationsreported" : {
                    "default" : "",
                    "description" : "Set the \"None Reported\" checkbox indicating that no medications were reported for this patient.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "sectionnote" : {
                    "default" : "",
                    "description" : "The section-wide note for medications.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/medications"
           },
           "PUT /chart/{patientid}/medications/{medicationentryid}" : {
              "description" : "Update properties of a given medication",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":medicationentryid" : {
                    "default" : null,
                    "description" : "medicationentryid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenanet department ID",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "hidden" : {
                    "default" : "",
                    "description" : "Set whether the medication is hidden in the UI.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "patientnote" : {
                    "default" : "",
                    "description" : "A patient-facing note",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "providernote" : {
                    "default" : "",
                    "description" : "An internal note",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "startdate" : {
                    "default" : "",
                    "description" : "Start date for this medication",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "stopdate" : {
                    "default" : "",
                    "description" : "Stop date for this medication",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "stopreason" : {
                    "default" : "",
                    "description" : "The reason the medication was stopped. If set, it it recommended but not required that a stop date is also set.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "unstructuredsig" : {
                    "default" : "",
                    "description" : "Can only be used to update historical (entered, downloaded, etc) medications. Will override a structured sig if there is one.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/medications/:medicationentryid"
           },
           "GET /chart/{patientid}/obgynhistory" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/obgynhistory"
           },
           "PUT /chart/{patientid}/obgynhistory" : {
              "description" : "OBGYNHistory for this chart",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "questions" : {
                    "default" : "",
                    "description" : "A JSON array of questions mimicking [the input](https://developer.athenahealth.com/docs/read/chart/List_of_OB_GYN_History_Questions) described in the PUT call.",
                    "location" : "query",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "sectionnote" : {
                    "default" : "",
                    "description" : "Any additional section notes",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/obgynhistory"
           },
           "GET /chart/{patientid}/problems" : {
              "description" : "Gets the list of patient problems",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "showinactive" : {
                    "default" : "",
                    "description" : "Also show inactive (but not soft deleted) problems.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/problems"
           },
           "POST /chart/{patientid}/problems" : {
              "description" : "Add a new problem for this patient.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "laterality" : {
                    "default" : "",
                    "description" : "Update the laterality of this problem. Can be null, LEFT, RIGHT, or BILATERAL.",
                    "enum" : [
                       "",
                       "LEFT",
                       "RIGHT",
                       "BILATERAL"
                    ],
                    "enumDescriptions" : [
                       "",
                       "LEFT",
                       "RIGHT",
                       "BILATERAL"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "note" : {
                    "default" : "",
                    "description" : "The note to be attached to this problem.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "snomedcode" : {
                    "default" : "",
                    "description" : "The [SNOMED code](http://www.nlm.nih.gov/research/umls/Snomed/snomed_browsers.html) of the problem you are adding.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "startdate" : {
                    "default" : "",
                    "description" : "The onset date to be updated for this problem in MM/DD/YYYY format.",
                    "format" : "date",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/problems"
           },
           "PUT /chart/{patientid}/problems/{problemid}" : {
              "description" : "Gets the list of patient problems",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":problemid" : {
                    "default" : null,
                    "description" : "problemid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "laterality" : {
                    "default" : "",
                    "description" : "Update the laterality of this problem. Can be null, LEFT, RIGHT, or BILATERAL.",
                    "enum" : [
                       "",
                       "LEFT",
                       "RIGHT",
                       "BILATERAL"
                    ],
                    "enumDescriptions" : [
                       "",
                       "LEFT",
                       "RIGHT",
                       "BILATERAL"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "note" : {
                    "default" : "",
                    "description" : "The note to be attached to this problem.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "startdate" : {
                    "default" : "",
                    "description" : "The onset date to be updated for this problem in MM/DD/YYYY format.",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/problems/:problemid"
           },
           "DELETE /chart/{patientid}/problems/{problemid}" : {
              "description" : "Adds an end date of today and hides this problem in the UI.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":problemid" : {
                    "default" : null,
                    "description" : "problemid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/problems/:problemid"
           },
           "GET /chart/{patientid}/socialhistory" : {
              "description" : "Returns the list of social history questions for this patient.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "showunansweredquestions" : {
                    "default" : "",
                    "description" : "Include questions where there is no current answer.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/socialhistory"
           },
           "PUT /chart/{patientid}/socialhistory" : {
              "description" : "Update the set of social history questions for this patient",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department for this patient. A patient may have multiple charts, and the department determines which chart to retrieve.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "questions" : {
                    "default" : "",
                    "description" : "The list of question/answer pairs to be submitted. A JSON array of questions mimicking [the inputs](https://developer.athenahealth.com/docs/read/chart/Social_History) described in the PUT call. Only the questions submitted will be added/updated/deleted.",
                    "location" : "query",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "sectionnote" : {
                    "default" : "",
                    "description" : "A section-wide note",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/socialhistory"
           },
           "GET /chart/{patientid}/socialhistory/templates" : {
              "description" : "Returns the list of selected social history templates for this patient.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/socialhistory/templates"
           },
           "PUT /chart/{patientid}/socialhistory/templates" : {
              "description" : "Returns the list of social history questions for this patient.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "templateids" : {
                    "default" : "",
                    "description" : "A comma separated list of template IDs to subscribe to.",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/socialhistory/templates"
           },
           "GET /chart/{patientid}/surgicalhistory" : {
              "description" : "SurgicalHistory for this chart",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/surgicalhistory"
           },
           "POST /chart/{patientid}/surgicalhistory" : {
              "description" : "SurgicalHistory for this chart",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "procedures" : {
                    "default" : "",
                    "description" : "A JSON array of procedures, mimicking [the inputs](https://developer.athenahealth.com/docs/read/chart/Surgical_History) described in the PUT/POST call. It is good practice to use the POST call whenever adding new surgical history, however do take note that when calling PUT, any procedures without a procedureid in the PUT call will also add new history.",
                    "location" : "body",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "sectionnote" : {
                    "default" : "",
                    "description" : "Any additional section notes",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/surgicalhistory"
           },
           "PUT /chart/{patientid}/surgicalhistory" : {
              "description" : "SurgicalHistory for this chart",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "procedures" : {
                    "default" : "",
                    "description" : "A JSON array of procedures, mimicking [the inputs](https://developer.athenahealth.com/docs/read/chart/Surgical_History) described in the PUT/POST call. It is good practice to use the POST call whenever adding new surgical history, however do take note that when calling PUT, any procedures without a procedureid in the PUT call will also add new history.",
                    "location" : "query",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "sectionnote" : {
                    "default" : "",
                    "description" : "Any additional section notes",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/surgicalhistory"
           },
           "GET /chart/{patientid}/vaccines" : {
              "description" : "Vaccines for this chart",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "",
                    "description" : "Include deleted vaccines in the result",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showprescribednotadministered" : {
                    "default" : "",
                    "description" : "Include vaccines that were prescribed but were not administered in the result",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showrefused" : {
                    "default" : "",
                    "description" : "Include refused vaccines in the result",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/vaccines"
           },
           "POST /chart/{patientid}/vaccines" : {
              "description" : "Vaccine add logic for this chart",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "administerdate" : {
                    "default" : "",
                    "description" : "Date when this vaccine was administered (if administered)",
                    "format" : "date",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "cvx" : {
                    "default" : "",
                    "description" : "Vaccine Administered Code",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/vaccines"
           },
           "PUT /chart/{patientid}/vaccines/{vaccineid}" : {
              "description" : "Vaccine add logic for this chart",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":vaccineid" : {
                    "default" : null,
                    "description" : "vaccineid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "administerdate" : {
                    "default" : "",
                    "description" : "Date when this vaccine was administered (if administered)",
                    "format" : "date",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "cvx" : {
                    "default" : "",
                    "description" : "Vaccine Administered Code",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/vaccines/:vaccineid"
           },
           "DELETE /chart/{patientid}/vaccines/{vaccineid}" : {
              "description" : "Vaccine update logic for this chart",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":vaccineid" : {
                    "default" : null,
                    "description" : "vaccineid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "deleteddate" : {
                    "default" : "",
                    "description" : "Date when this vaccine record was deleted from athenaNet (defaults to today)",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/vaccines/:vaccineid"
           },
           "GET /chart/{patientid}/vitals" : {
              "description" : "Returns the list of vitals for the given patient. Each vital might have several attributes, some of which might not have any readings. By default vitals with no readings are skipped unless SHOWEMPTYVITALS is set. Even without that set you will still be shown vital attributes that have no readings.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department for this patient. A patient may have multiple charts, and the department determines which chart to retrieve.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showemptyvitals" : {
                    "default" : "",
                    "description" : "Show configured vitals that have no readings for this patient.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "source" : {
                    "default" : "ENCOUNTER",
                    "description" : "The source of the vitals. Currently only ENCOUNTER based vitals are supported.",
                    "enum" : [
                       "ENCOUNTER"
                    ],
                    "enumDescriptions" : [
                       "ENCOUNTER"
                    ],
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/vitals"
           },
           "POST /chart/{patientid}/vitals" : {
              "description" : "Add a set of new vital readings for this patient.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department for this patient. A patient may have multiple charts, and the department determines which chart to retrieve.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "source" : {
                    "default" : "ENCOUNTER",
                    "description" : "The source of the vitals. Currently only ENCOUNTER based vitals are supported.",
                    "enum" : [
                       "ENCOUNTER"
                    ],
                    "enumDescriptions" : [
                       "ENCOUNTER"
                    ],
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "sourceid" : {
                    "default" : "",
                    "description" : "An ID used to further specify the source, ex. EncounterID. Currently only required if source=ENCOUNTER.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "vitals" : {
                    "default" : "",
                    "description" : "This is an array of arrays in JSON.  Each subarray contains a group of related readings, like systolic and diastolic blood pressure. They will be assigned the same readingID",
                    "location" : "body",
                    "required" : true,
                    "type" : "textarea"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/vitals"
           },
           "PUT /chart/{patientid}/vitals/{vitalid}" : {
              "description" : "Update a single vital attribute reading",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":vitalid" : {
                    "default" : null,
                    "description" : "vitalid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department for this patient. A patient may have multiple charts, and the department determines which chart to retrieve.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "source" : {
                    "default" : "ENCOUNTER",
                    "description" : "The source of the vitals. Currently only ENCOUNTER based vitals are supported.",
                    "enum" : [
                       "ENCOUNTER"
                    ],
                    "enumDescriptions" : [
                       "ENCOUNTER"
                    ],
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "value" : {
                    "default" : "",
                    "description" : "The reading value. See the configuration for the proper units.",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/vitals/:vitalid"
           },
           "DELETE /chart/{patientid}/vitals/{vitalid}" : {
              "description" : "Deletes the given vital entry. Only deletes a single value (so the diastolic, systolic, and BP types must be deleted separately). NOTE: currently only deletes source=ENCOUNTER vitals.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":vitalid" : {
                    "default" : null,
                    "description" : "vitalid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/:patientid/vitals/:vitalid"
           },
           "GET /patients/{patientid}/ccda" : {
              "description" : "Get the patient's ambulatory summary (continuity of care document) in CCDA format (XML).  See [CCDA overview](http://www.healthit.gov/policy-researchers-implementers/consolidated-cda-overview)\tfor more information.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department from which to retrieve the patient's chart.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "purpose" : {
                    "default" : "",
                    "description" : "The purpose of this request. The sections returned and required patient consent will depend on the purpose. For now we will only support 'internal', which means it's being requested on behalf of the practice.",
                    "enum" : [
                       "internal"
                    ],
                    "enumDescriptions" : [
                       "Internal to Practice"
                    ],
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "xmloutput" : {
                    "default" : "",
                    "description" : "If set to true, use XML (not JSON) as output.  Not needed if an Accept header with application/xml header is included in the request. If set to false, it will return the CCDA format (XML) wrapped in a JSON response.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "N",
                       "Y"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/ccda"
           },
           "GET /reference/allergies" : {
              "description" : "Return a short list of allergies matching the search term.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "searchvalue" : {
                    "default" : "",
                    "description" : "A term to search for. Must be at least 2 characters",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/reference/allergies"
           },
           "GET /reference/allergies/reactions" : {
              "description" : "Returns the list of valid allergy reactions",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/reference/allergies/reactions"
           },
           "GET /reference/allergies/severities" : {
              "description" : "Returns the list of valid allergy severities",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/reference/allergies/severities"
           },
           "GET /reference/medications" : {
              "description" : "Autocomplete get request",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "searchvalue" : {
                    "default" : "",
                    "description" : "A term to search for. Must be at least 2 characters",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/reference/medications"
           },
           "GET /reference/medications/stopreasons" : {
              "description" : "List of valid medication stop reasons.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/reference/medications/stopreasons"
           }
        }
     },
     "Encounter" : {
        "methods" : {
           "GET /chart/configuration/officeordertypes" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/chart/configuration/officeordertypes"
           },
           "GET /chart/configuration/patientlocations" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/configuration/patientlocations"
           },
           "GET /chart/configuration/patientstatuses" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/chart/configuration/patientstatuses"
           },
           "GET /chart/configuration/questionnairescreeners" : {
              "description" : "Retreive a list of possible questionnaire screeners for a given appointment ID or encounter ID.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The appointment ID. It is used solely to determine the specialty ID to determine possible questionnaires. If an encounter ID is passed in, it will take priority over the appointment ID.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "encounterid" : {
                    "default" : "",
                    "description" : "The encounter ID. It is used solely to determine the specialty ID to determine the possible questionnaires.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 100, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "patientid" : {
                    "default" : "",
                    "description" : "The patient ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/configuration/questionnairescreeners"
           },
           "GET /chart/encounter/{encounterid}" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounter/:encounterid"
           },
           "PUT /chart/encounter/{encounterid}" : {
              "description" : "Update some basic information about an encounter",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "patientlocationid" : {
                    "default" : "",
                    "description" : "The practice patient location id. You can get a list of valid values by department via GET /chart/configuration/patientlocations.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "patientstatusid" : {
                    "default" : "",
                    "description" : "The practice patient status id. You can get a list of valid values by department via GET /chart/configuration/patientstatuses.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounter/:encounterid"
           },
           "GET /chart/encounter/{encounterid}/assessment" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounter/:encounterid/assessment"
           },
           "GET /chart/encounter/{encounterid}/diagnoses" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounter/:encounterid/diagnoses"
           },
           "GET /chart/encounter/{encounterid}/encounterreasons" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounter/:encounterid/encounterreasons"
           },
           "GET /chart/encounter/{encounterid}/orders" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounter/:encounterid/orders"
           },
           "GET /chart/encounter/{encounterid}/patientgoals" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounter/:encounterid/patientgoals"
           },
           "GET /chart/encounter/{encounterid}/physicalexam" : {
              "description" : "Get the physical exam summary for an encounter.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "showstructured" : {
                    "default" : "",
                    "description" : "If true, returns the physical exam as structured data. If false, returns it via lightly-HTML marked up English text, as displayed in the athenanet encounter summary.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounter/:encounterid/physicalexam"
           },
           "GET /chart/encounter/{encounterid}/proceduredocumentation" : {
              "description" : "Returns the procedure documentation associated with an encounter",
              "httpMethod" : "GET",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showhtml" : {
                    "default" : "false",
                    "description" : "Procedure documentation is stored as HTML templates filled in by the practice.  By default, we strip out all HTML when returning the data back through the API.  However, there are times when preserving the HTML formatting may be useful. If SHOWHTML is set to true, the original HTML from the template is preserved when returning data back through the API.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounter/:encounterid/proceduredocumentation"
           },
           "GET /chart/encounter/{encounterid}/questionnairescreeners" : {
              "description" : "Retrieve a list of currently enabled questionnaire screeners for the encounter.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 100, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounter/:encounterid/questionnairescreeners"
           },
           "POST /chart/encounter/{encounterid}/questionnairescreeners" : {
              "description" : "Activate a questionnaire screener using the template ID",
              "httpMethod" : "POST",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "templateid" : {
                    "default" : "",
                    "description" : "The template ID for the screener that will be activated.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounter/:encounterid/questionnairescreeners"
           },
           "PUT /chart/encounter/{encounterid}/questionnairescreeners" : {
              "description" : "Update a questionnaire screener. For SCOREONLY questionnaire screeners, please use the /chart/encounter/{encounterid}/questionnairescreeners/scoreonly API.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "documentids" : {
                    "default" : "",
                    "description" : "A comma delimited array of document IDs to attach to the questionnaire.",
                    "location" : "query",
                    "required" : true,
                    "type" : "array"
                 },
                 "guidelines" : {
                    "default" : "",
                    "description" : "The guidelines given by the score and questionnaire.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "note" : {
                    "default" : "",
                    "description" : "The note for the questionnaire screener.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "questionnaireid" : {
                    "default" : "",
                    "description" : "The questionnaire ID to be updated. If the questionnaireid does not exist in the GET /chart/encounter/{encounterid}/questionnairescreeners API, please activate it via the POST API.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "questions" : {
                    "default" : "",
                    "description" : "A JSON array of questions that contain a questionid and answer.",
                    "location" : "query",
                    "required" : true,
                    "type" : "textarea"
                 },
                 "score" : {
                    "default" : "",
                    "description" : "The score for the questionnaire screener. This is not automatically updated based on the questions and answers passed in.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounter/:encounterid/questionnairescreeners"
           },
           "PUT /chart/encounter/{encounterid}/questionnairescreeners/scoreonly" : {
              "description" : "Update a score-only questionnaire screener. Please use PUT /chart/encounter/{encounterid}/questionnairescreeners for other questionnaires.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "documentids" : {
                    "default" : "",
                    "description" : "A comma delimited array of document IDs to attach to the questionnaire. Ex: [4,5]",
                    "location" : "query",
                    "required" : true,
                    "type" : "array"
                 },
                 "note" : {
                    "default" : "",
                    "description" : "The note for the questionnaire screener.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "questionnaireid" : {
                    "default" : "",
                    "description" : "The questionnaire ID to be updated. If the questionnaireid does not exist in the GET /chart/encounter/{encounterid}/questionnairescreeners API, please activate it via the POST API.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "score" : {
                    "default" : "",
                    "description" : "The score for the questionnaire screener. Screeners that have one or more scores should be entered in the NOTE field.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounter/:encounterid/questionnairescreeners/scoreonly"
           },
           "GET /chart/encounters/{encounterid}/summary" : {
              "description" : "The HTML Summary for an encounter",
              "httpMethod" : "GET",
              "parameters" : {
                 ":encounterid" : {
                    "default" : null,
                    "description" : "encounterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "mobile" : {
                    "default" : "",
                    "description" : "Flag to skip many details to make the html smaller",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "skipamendments" : {
                    "default" : "",
                    "description" : "Flag to skip encounter amendments",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/chart/encounters/:encounterid/summary"
           }
        }
     },
     "Forms and Documents" : {
        "methods" : {
           "GET /appointments/{appointmentid}/healthhistoryforms" : {
              "description" : "List of health history forms for this appointment.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/healthhistoryforms"
           },
           "GET /appointments/{appointmentid}/healthhistoryforms/{formid}" : {
              "description" : "Get patient specific health history form. Required before any submissions.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":formid" : {
                    "default" : null,
                    "description" : "formid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "shownullanswers" : {
                    "default" : "",
                    "description" : "If true, unanswered questions in the medical history, surgical history, and vaccine sections return null. If false (default), they return 'N'.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/healthhistoryforms/:formid"
           },
           "PUT /appointments/{appointmentid}/healthhistoryforms/{formid}" : {
              "description" : "Submit patient health history form. Refer to [health history forms](https://developer.athenahealth.com/docs/read/workflows/Health_History_Forms) for more information.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":formid" : {
                    "default" : null,
                    "description" : "formid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "healthhistoryform" : {
                    "default" : "",
                    "description" : "JSON object containing the health history form to update.",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/healthhistoryforms/:formid"
           },
           "GET /configuration/inbox/staff" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/configuration/inbox/staff"
           },
           "GET /healthhistoryforms" : {
              "description" : "List of health history forms live at practice.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/healthhistoryforms"
           },
           "GET /healthhistoryforms/{formid}" : {
              "description" : "Contents of one generic health history form.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":formid" : {
                    "default" : null,
                    "description" : "formid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/healthhistoryforms/:formid"
           },
           "GET /patients/{patientid}/documents" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "documentclass" : {
                    "default" : "",
                    "description" : "The class(es) of document(s) comma separated.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents"
           },
           "POST /patients/{patientid}/documents" : {
              "description" : "Create a document in athenaNet",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "multipart/form-data",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "actionnote" : {
                    "default" : "",
                    "description" : "Any note to accompany the creation of this document.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The appointment ID associated with this document, for certain document classes. These can only be uploaded AFTER check-in. The department ID is looked up from the appointment. (Department ID takes precedence if both are supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "attachmentcontents" : {
                    "default" : "",
                    "description" : "The file that will become the document. PDFs are recommended. Generally, this implies that this is a multipart/form-data content-type submission. This does NOT work correctly in I/O Docs. The filename itself is not used by athenaNet, but it is required to be sent.",
                    "location" : "body",
                    "required" : true,
                    "type" : "any"
                 },
                 "autoclose" : {
                    "default" : "",
                    "description" : "Normally, documents will follow the automatic workflow. In some cases, you might want to force the document to be closed.  For that case, set this to true.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID associated with the uploaded document. Except when appointmentid is supplied, this is required.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "documentsubclass" : {
                    "default" : "",
                    "description" : "The document subclass.",
                    "enum" : [
                       "ADMIN_BILLING",
                       "ADMIN_CONSENT",
                       "ADMIN_HIPAA",
                       "ADMIN_INSURANCEAPPROVAL",
                       "ADMIN_INSURANCECARD",
                       "ADMIN_INSURANCEDENIAL",
                       "ADMIN_LEGAL",
                       "ADMIN_MEDICALRECORDREQ",
                       "ADMIN_REFERRAL",
                       "ADMIN_SIGNEDFORMSLETTERS",
                       "ADMIN_VACCINATIONRECORD",
                       "CLINICALDOCUMENT",
                       "CLINICALDOCUMENT_ADMISSIONDISCHARGE",
                       "CLINICALDOCUMENT_CONSULTNOTE",
                       "CLINICALDOCUMENT_MENTALHEALTH",
                       "CLINICALDOCUMENT_OPERATIVENOTE",
                       "CLINICALDOCUMENT_URGENTCARE",
                       "ENCOUNTERDOCUMENT_IMAGEDOC",
                       "ENCOUNTERDOCUMENT_PATIENTHISTORY",
                       "ENCOUNTERDOCUMENT_PROCEDUREDOC",
                       "ENCOUNTERDOCUMENT_PROGRESSNOTE",
                       "MEDICALRECORD_CHARTTOABSTRACT",
                       "MEDICALRECORD_COUMADIN",
                       "MEDICALRECORD_GROWTHCHART",
                       "MEDICALRECORD_HISTORICAL",
                       "MEDICALRECORD_PATIENTDIARY",
                       "MEDICALRECORD_VACCINATION",
                       "PHONEMESSAGE"
                    ],
                    "enumDescriptions" : [
                       "ADMIN_BILLING: Billing Document",
                       "ADMIN_CONSENT: Consent",
                       "ADMIN_HIPAA: HIPAA/Privacy",
                       "ADMIN_INSURANCEAPPROVAL: Insurance Approval Notification",
                       "ADMIN_INSURANCECARD: Insurance Card",
                       "ADMIN_INSURANCEDENIAL: Insurance Denial Notification",
                       "ADMIN_LEGAL: Legal",
                       "ADMIN_MEDICALRECORDREQ: Medical Records Request",
                       "ADMIN_REFERRAL: Referral",
                       "ADMIN_SIGNEDFORMSLETTERS: Signed Forms & Letters",
                       "ADMIN_VACCINATIONRECORD: Vaccination Record",
                       "CLINICALDOCUMENT: Clinical Document",
                       "CLINICALDOCUMENT_ADMISSIONDISCHARGE: Admission/Discharge Summary",
                       "CLINICALDOCUMENT_CONSULTNOTE: Consult Note",
                       "CLINICALDOCUMENT_MENTALHEALTH: Mental Health Consult",
                       "CLINICALDOCUMENT_OPERATIVENOTE: Operative Note",
                       "CLINICALDOCUMENT_URGENTCARE: Emergency/Urgent Care",
                       "ENCOUNTERDOCUMENT_IMAGEDOC: Image Documentation",
                       "ENCOUNTERDOCUMENT_PATIENTHISTORY: Health History Questionnaire (requires appointmentid for a checked in appointment)",
                       "ENCOUNTERDOCUMENT_PROCEDUREDOC: Procedure Documentation (requires appointmentid for a checked in appointment)",
                       "ENCOUNTERDOCUMENT_PROGRESSNOTE: Progress Note (requires appointmentid for a checked in appointment)",
                       "MEDICALRECORD_CHARTTOABSTRACT: Chart for Abstraction",
                       "MEDICALRECORD_COUMADIN: Flowsheet",
                       "MEDICALRECORD_GROWTHCHART: Growth Chart",
                       "MEDICALRECORD_HISTORICAL: Historical Medical Record",
                       "MEDICALRECORD_PATIENTDIARY: Patient Diary",
                       "MEDICALRECORD_VACCINATION: Vaccination Record",
                       "PHONEMESSAGE: Phone Message"
                    ],
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "internalnote" : {
                    "default" : "",
                    "description" : "The 'Internal Note' attached to this document",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "providerid" : {
                    "default" : "",
                    "description" : "The provider ID attached to this document. This populates the provider name field.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents"
           },
           "GET /patients/{patientid}/documents/acog" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/acog"
           },
           "GET /patients/{patientid}/documents/admin" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/admin"
           },
           "GET /patients/{patientid}/documents/admin/{adminid}" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":adminid" : {
                    "default" : null,
                    "description" : "adminid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/admin/:adminid"
           },
           "GET /patients/{patientid}/documents/admin/{adminid}/pages/{pageid}" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":adminid" : {
                    "default" : null,
                    "description" : "adminid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":pageid" : {
                    "default" : null,
                    "description" : "pageid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/admin/:adminid/pages/:pageid"
           },
           "GET /patients/{patientid}/documents/appointmentrequest" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/appointmentrequest"
           },
           "GET /patients/{patientid}/documents/chartabstraction" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/chartabstraction"
           },
           "GET /patients/{patientid}/documents/clinicaldocument" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/clinicaldocument"
           },
           "GET /patients/{patientid}/documents/clinicaldocument/{documentid}/xml" : {
              "description" : "Allows retrieval of certain types of clinical documents which contain XML (such as CCDAs)",
              "httpMethod" : "GET",
              "parameters" : {
                 ":documentid" : {
                    "default" : null,
                    "description" : "documentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/clinicaldocument/:documentid/xml"
           },
           "GET /patients/{patientid}/documents/coversheet" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/coversheet"
           },
           "GET /patients/{patientid}/documents/dme" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/dme"
           },
           "GET /patients/{patientid}/documents/encounterdocument" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/encounterdocument"
           },
           "GET /patients/{patientid}/documents/encounterdocument/{encounterdocumentid}" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":encounterdocumentid" : {
                    "default" : null,
                    "description" : "encounterdocumentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/encounterdocument/:encounterdocumentid"
           },
           "GET /patients/{patientid}/documents/encounterdocument/{encounterdocumentid}/pages/{pageid}" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":encounterdocumentid" : {
                    "default" : null,
                    "description" : "encounterdocumentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":pageid" : {
                    "default" : null,
                    "description" : "pageid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/encounterdocument/:encounterdocumentid/pages/:pageid"
           },
           "GET /patients/{patientid}/documents/hospital" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/hospital"
           },
           "GET /patients/{patientid}/documents/html" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/html"
           },
           "GET /patients/{patientid}/documents/imagingresult" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/imagingresult"
           },
           "GET /patients/{patientid}/documents/imagingresult/{imagingresultid}" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":imagingresultid" : {
                    "default" : null,
                    "description" : "imagingresultid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/imagingresult/:imagingresultid"
           },
           "GET /patients/{patientid}/documents/imagingresult/{imagingresultid}/pages/{pageid}" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":imagingresultid" : {
                    "default" : null,
                    "description" : "imagingresultid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":pageid" : {
                    "default" : null,
                    "description" : "pageid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/imagingresult/:imagingresultid/pages/:pageid"
           },
           "GET /patients/{patientid}/documents/interpretation" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/interpretation"
           },
           "GET /patients/{patientid}/documents/labresult" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/labresult"
           },
           "GET /patients/{patientid}/documents/labresult/{labresultid}" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":labresultid" : {
                    "default" : null,
                    "description" : "labresultid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/labresult/:labresultid"
           },
           "GET /patients/{patientid}/documents/labresult/{labresultid}/pages/{pageid}" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":labresultid" : {
                    "default" : null,
                    "description" : "labresultid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":pageid" : {
                    "default" : null,
                    "description" : "pageid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/labresult/:labresultid/pages/:pageid"
           },
           "GET /patients/{patientid}/documents/letter" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/letter"
           },
           "GET /patients/{patientid}/documents/letter/{letterid}" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":letterid" : {
                    "default" : null,
                    "description" : "letterid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/letter/:letterid"
           },
           "GET /patients/{patientid}/documents/medicalrecord" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/medicalrecord"
           },
           "GET /patients/{patientid}/documents/mednotification" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/mednotification"
           },
           "GET /patients/{patientid}/documents/officenote" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/officenote"
           },
           "GET /patients/{patientid}/documents/order" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/order"
           },
           "GET /patients/{patientid}/documents/patientcase" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/patientcase"
           },
           "GET /patients/{patientid}/documents/patientcase/{patientcaseid}" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientcaseid" : {
                    "default" : null,
                    "description" : "patientcaseid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/patientcase/:patientcaseid"
           },
           "GET /patients/{patientid}/documents/patientinfo" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/patientinfo"
           },
           "GET /patients/{patientid}/documents/patientrecord" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/patientrecord"
           },
           "GET /patients/{patientid}/documents/phonemessage" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/phonemessage"
           },
           "GET /patients/{patientid}/documents/physicianauth" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/physicianauth"
           },
           "GET /patients/{patientid}/documents/prescription" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/prescription"
           },
           "PUT /patients/{patientid}/documents/prescriptions/{prescriptionid}" : {
              "description" : "Updates the order document.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":prescriptionid" : {
                    "default" : null,
                    "description" : "prescriptionid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "actionnote" : {
                    "default" : "",
                    "description" : "The note appended to the action taken on the document. This field supports line breaks in the form of '\\n' and '\\r\\n'.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "internalnote" : {
                    "default" : "",
                    "description" : "The internal note for the document. This field supports line breaks in the form of '\\n' and '\\r\\n'.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "note" : {
                    "default" : "",
                    "description" : "The note to be appended to the document. This field supports line breaks in the form of '\\n' and '\\r\\n'.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "pintotop" : {
                    "default" : "",
                    "description" : "If set, pins the ACTIONNOTE to the top of the workflow.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/prescriptions/:prescriptionid"
           },
           "GET /patients/{patientid}/documents/rto" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/rto"
           },
           "GET /patients/{patientid}/documents/rto/{rtoid}" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":rtoid" : {
                    "default" : null,
                    "description" : "rtoid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/rto/:rtoid"
           },
           "GET /patients/{patientid}/documents/surgery" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/surgery"
           },
           "GET /patients/{patientid}/documents/surgicalresult" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/surgicalresult"
           },
           "GET /patients/{patientid}/documents/unknown" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/unknown"
           },
           "GET /patients/{patientid}/documents/vaccine" : {
              "description" : "Basic get request, takes no parameters other than department id",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "false",
                    "description" : "By default, deleted documents are not listed.  Set to list these.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/documents/vaccine"
           },
           "GET /patients/{patientid}/driverslicense" : {
              "description" : "Gets the patient's driver's license. You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additional information.\n\ncurl -H \"Authorization: Bearer {Authorization Token}\" -X GET \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/driverslicense?jpegoutput={true|false}\"",
              "httpMethod" : "GET",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "jpegoutput" : {
                    "default" : "",
                    "description" : "If set to true, or if Accept header is image/jpeg, returns the image directly.  (The image may be scaled.)",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/driverslicense"
           },
           "POST /patients/{patientid}/driverslicense" : {
              "description" : "PUT/POST are the same and update a patient's driver's license. You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additional information.\n\ncurl -H \"Authorization: Bearer {Authorization Token}\" -F \"image=@{Path to image file}\" \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/driverslicense\"",
              "httpMethod" : "POST",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "multipart/form-data",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID associated with this upload.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "image" : {
                    "default" : "",
                    "description" : "Base64 encoded image, or, if multipart/form-data, unencoded image. This image may be scaled down after submission. PUT is not recommended when using multipart/form-data. Since POST and PUT have identical functionality, POST is recommended.",
                    "location" : "body",
                    "required" : true,
                    "type" : "file"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/driverslicense"
           },
           "PUT /patients/{patientid}/driverslicense" : {
              "description" : "PUT/POST are the same and update a patient's driver's license. You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additional information.\n\ncurl -H \"Authorization: Bearer {Authorization Token}\" -F \"image=@{Path to image file}\" \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/driverslicense\"",
              "httpMethod" : "PUT",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "multipart/form-data",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID associated with this upload.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "image" : {
                    "default" : "",
                    "description" : "Base64 encoded image, or, if multipart/form-data, unencoded image. This image may be scaled down after submission. PUT is not recommended when using multipart/form-data. Since POST and PUT have identical functionality, POST is recommended.",
                    "location" : "query",
                    "required" : true,
                    "type" : "file"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/driverslicense"
           },
           "DELETE /patients/{patientid}/driverslicense" : {
              "description" : "Deletes a patient's driver's license.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/driverslicense"
           },
           "POST /patients/{patientid}/medicationhistoryconsentverified" : {
              "description" : "Flag the medication history consent flag as having been verified.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the privacy information was verified.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "medicationhistoryconsentby" : {
                    "default" : "",
                    "description" : "The person who verified the medication history consent. Accepted values are 'PATIENT' and 'OTHER.'  If no value is provided, then 'PATIENT' is used.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "reasonpatientunabletosign" : {
                    "default" : "",
                    "description" : "If the patient is unable to sign a reason why.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "signaturedatetime" : {
                    "default" : "",
                    "description" : "If presenting an e-signature, the mm/dd/yyyy hh24:mi:ss formatted time that the signer signed.  This is required if a signature name is provided.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "signaturename" : {
                    "default" : "",
                    "description" : "If presenting an e-siganture, the name the signer typed, up to 100 characters",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "signerrelationshiptopatientid" : {
                    "default" : "",
                    "description" : "If presenting an e-signature, and the signer is signing on behalf of someone else, the relationship of the patient to the signer.  There is a documentation page with details.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/medicationhistoryconsentverified"
           },
           "GET /patients/{patientid}/patientcases" : {
              "description" : "Basic get request, takes no parameters",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The athenaNet department id.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/patientcases"
           },
           "GET /patients/{patientid}/photo" : {
              "description" : "Gets the patient's photo. You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additional information.\n\ncurl -H \"Authorization: Bearer {Authorization Token}\" -X GET \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/photo?jpegoutput={true|false}\"",
              "httpMethod" : "GET",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "jpegoutput" : {
                    "default" : "",
                    "description" : "If set to true, or if Accept header is image/jpeg, returns the image directly.  (The image may be scaled.)",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/photo"
           },
           "POST /patients/{patientid}/photo" : {
              "description" : "PUT/POST are the same and update a patient's photo. You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additional information.\n\ncurl -H \"Authorization: Bearer {Authorization Token}\" -F \"image=@{Path to image file}\" \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/photo\"",
              "httpMethod" : "POST",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "multipart/form-data",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID associated with this upload.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "image" : {
                    "default" : "",
                    "description" : "Base64 encoded image, or, if multipart/form-data, unencoded image. This image may be scaled down after submission. PUT is not recommended when using multipart/form-data. Since POST and PUT have identical functionality, POST is recommended.",
                    "location" : "body",
                    "required" : true,
                    "type" : "file"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/photo"
           },
           "PUT /patients/{patientid}/photo" : {
              "description" : "PUT/POST are the same and update a patient's photo. You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additional information.\n\ncurl -H \"Authorization: Bearer {Authorization Token}\" -F \"image=@{Path to image file}\" \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/photo\"",
              "httpMethod" : "PUT",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "multipart/form-data",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID associated with this upload.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "image" : {
                    "default" : "",
                    "description" : "Base64 encoded image, or, if multipart/form-data, unencoded image. This image may be scaled down after submission. PUT is not recommended when using multipart/form-data. Since POST and PUT have identical functionality, POST is recommended.",
                    "location" : "query",
                    "required" : true,
                    "type" : "file"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/photo"
           },
           "DELETE /patients/{patientid}/photo" : {
              "description" : "Deletes a patient's photo.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/photo"
           },
           "GET /patients/{patientid}/photo/thumbnail" : {
              "description" : "Gets the patient's photo. You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additional information.\n\ncurl -H \"Authorization: Bearer {Authorization Token}\" -X GET \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/photo/thumbnail?jpegoutput={true|false}\"",
              "httpMethod" : "GET",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "jpegoutput" : {
                    "default" : "",
                    "description" : "If set to true, or if Accept header is image/jpeg, returns the image directly.  (The image may be scaled.)",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/photo/thumbnail"
           },
           "POST /patients/{patientid}/photo/thumbnail" : {
              "description" : "PUT/POST are the same and update a patient's photo. You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additional information.\n\ncurl -H \"Authorization: Bearer {Authorization Token}\" -F \"image=@{Path to image file}\" \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/photo/thumbnail\"",
              "httpMethod" : "POST",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "multipart/form-data",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID associated with this upload.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "image" : {
                    "default" : "",
                    "description" : "Base64 encoded image, or, if multipart/form-data, unencoded image. This image may be scaled down after submission. PUT is not recommended when using multipart/form-data. Since POST and PUT have identical functionality, POST is recommended.",
                    "location" : "body",
                    "required" : true,
                    "type" : "file"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/photo/thumbnail"
           },
           "PUT /patients/{patientid}/photo/thumbnail" : {
              "description" : "PUT/POST are the same and update a patient's photo. You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additional information.\n\ncurl -H \"Authorization: Bearer {Authorization Token}\" -F \"image=@{Path to image file}\" \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/photo/thumbnail\"",
              "httpMethod" : "PUT",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "multipart/form-data",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID associated with this upload.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "image" : {
                    "default" : "",
                    "description" : "Base64 encoded image, or, if multipart/form-data, unencoded image. This image may be scaled down after submission. PUT is not recommended when using multipart/form-data. Since POST and PUT have identical functionality, POST is recommended.",
                    "location" : "query",
                    "required" : true,
                    "type" : "file"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/photo/thumbnail"
           },
           "DELETE /patients/{patientid}/photo/thumbnail" : {
              "description" : "Deletes a patient's photo.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/photo/thumbnail"
           },
           "GET /providers/{providerid}/inbox" : {
              "description" : "Retrieve the tasks in the provider's inbox",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":providerid" : {
                    "default" : null,
                    "description" : "providerid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "inboxcategory" : {
                    "default" : "",
                    "description" : "The inbox category/bucket to filter, all others will be excluded.",
                    "enum" : [
                       "ADMIN",
                       "APPOINTMENTREQUEST",
                       "CLINICALDOCUMENT",
                       "CLINICALENCOUNTERVISIT",
                       "CLINICALRESULT",
                       "COORDINATORTASK",
                       "FOLLOWUP",
                       "ORDER",
                       "PATIENTCASE",
                       "UNKNOWN"
                    ],
                    "enumDescriptions" : [
                       "ADMIN: Admin Tasks / Phone Messages",
                       "APPOINTMENTREQUEST: Appointment Requests",
                       "CLINICALDOCUMENT: Clinical Documents",
                       "CLINICALENCOUNTERVISIT: Encounters",
                       "CLINICALRESULT: Lab Results / Lab Images / Lab Interpretations",
                       "COORDINATORTASK: Coordinator Tasks",
                       "FOLLOWUP: Tasks That Need Follow Up",
                       "ORDER: Orders / RXs / Auths",
                       "PATIENTCASE: Patient Cases",
                       "UNKNOWN: Unknown Documents"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "priority" : {
                    "default" : "",
                    "description" : "Priority to filter, all others will be excluded",
                    "enum" : [
                       "NORMAL",
                       "URGENT",
                       "CURRENT"
                    ],
                    "enumDescriptions" : [
                       "NORMAL",
                       "URGENT",
                       "CURRENT"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "status" : {
                    "default" : "",
                    "description" : "Status to filter, all others will be excluded",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "subtype" : {
                    "default" : "",
                    "description" : "The document class to filter, all others will be excluded",
                    "enum" : [
                       "Encounter",
                       "Document"
                    ],
                    "enumDescriptions" : [
                       "Encounter",
                       "Document"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/providers/:providerid/inbox"
           },
           "GET /providers/{providerid}/inbox/counts" : {
              "description" : "The count of tasks assigned to a provider by category",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":providerid" : {
                    "default" : null,
                    "description" : "providerid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/providers/:providerid/inbox/counts"
           },
           "GET /staff/inbox" : {
              "description" : "Retrieve the tasks in the provider's inbox",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "inboxcategory" : {
                    "default" : "",
                    "description" : "The inbox category/bucket to filter, all others will be excluded.",
                    "enum" : [
                       "ADMIN",
                       "APPOINTMENTREQUEST",
                       "CLINICALDOCUMENT",
                       "CLINICALENCOUNTERVISIT",
                       "CLINICALRESULT",
                       "COORDINATORTASK",
                       "FOLLOWUP",
                       "ORDER",
                       "PATIENTCASE",
                       "UNKNOWN"
                    ],
                    "enumDescriptions" : [
                       "ADMIN: Admin Tasks / Phone Messages",
                       "APPOINTMENTREQUEST: Appointment Requests",
                       "CLINICALDOCUMENT: Clinical Documents",
                       "CLINICALENCOUNTERVISIT: Encounters",
                       "CLINICALRESULT: Lab Results / Lab Images / Lab Interpretations",
                       "COORDINATORTASK: Coordinator Tasks",
                       "FOLLOWUP: Tasks That Need Follow Up",
                       "ORDER: Orders / RXs / Auths",
                       "PATIENTCASE: Patient Cases",
                       "UNKNOWN: Unknown Documents"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "priority" : {
                    "default" : "",
                    "description" : "Priority to filter, all others will be excluded",
                    "enum" : [
                       "NORMAL",
                       "URGENT",
                       "CURRENT"
                    ],
                    "enumDescriptions" : [
                       "NORMAL",
                       "URGENT",
                       "CURRENT"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "staffname" : {
                    "default" : "",
                    "description" : "Username to retrieve tasks by",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "status" : {
                    "default" : "",
                    "description" : "Status to filter, all others will be excluded",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "subtype" : {
                    "default" : "",
                    "description" : "The document class to filter, all others will be excluded",
                    "enum" : [
                       "Encounter",
                       "Document"
                    ],
                    "enumDescriptions" : [
                       "Encounter",
                       "Document"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/staff/inbox"
           }
        }
     },
     "Insurance/Financial" : {
        "methods" : {
           "POST /appointments/{appointmentid}/claim" : {
              "description" : "Creates a new claim for an appointment.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "claimcharges" : {
                    "default" : "",
                    "description" : "List of charges for this claim, This should be a JSON string representing an array of charge objects. Depending on whether the practice is actively coding in ICD-9 or ICD-10, one of either ICD9CODE1 or ICD10CODE1 is required. The /feeschedules/checkprocedure call may be used to verify a particular PROCEDURECODE is valid for a practice before attempting claim creation. Claims can only be created for appointments that do not already have a claim, are not already in status 4, and have already been checked in.",
                    "location" : "body",
                    "required" : true,
                    "type" : "textarea"
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/claim"
           },
           "GET /appointments/{appointmentid}/insurances" : {
              "description" : "Insurance packages for this appointment.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/appointments/:appointmentid/insurances"
           },
           "GET /claims" : {
              "description" : "Either appointment ID(s) are required OR a combination of both a start and end date and one (or both) or department and provider ID.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "One or more appointment IDs.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "createdenddate" : {
                    "default" : "",
                    "description" : "The claim creation date, end of range, inclusive.",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "createdstartdate" : {
                    "default" : "",
                    "description" : "The claim creation date, start of range, inclusive.",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID of the service department for the claims being searched for.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "providerid" : {
                    "default" : "",
                    "description" : "Will match either the provider or the supervising provider.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "serviceenddate" : {
                    "default" : "",
                    "description" : "The service date, end of range, inclusive.",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "servicestartdate" : {
                    "default" : "",
                    "description" : "The service date, start of range, inclusive.",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/claims"
           },
           "POST /claims/{claimid}/note" : {
              "description" : "Creates a new claim note for a claim.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":claimid" : {
                    "default" : null,
                    "description" : "claimid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "claimnote" : {
                    "default" : "",
                    "description" : "The text of the note.",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/claims/:claimid/note"
           },
           "GET /feeschedules/checkprocedure" : {
              "description" : "Finds the fee for a given procedure, based on given criteria",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID you are operating in.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "insurancepackageid" : {
                    "default" : "",
                    "description" : "The insurance package ID for which you want to find a fee.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "procedurecode" : {
                    "default" : "",
                    "description" : "The procedure code (including any modifiers) for which you want to find a fee (e.g \"99213\" or \"J12345,TC\"). Multiple codes (either as a tab delimited list or multiple POSTed values) are allowed.",
                    "location" : "query",
                    "required" : true,
                    "type" : "array"
                 },
                 "servicedate" : {
                    "default" : "",
                    "description" : "The date of service for which you want to check if a fee exists.  If not passed, defaults to today.",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/feeschedules/checkprocedure"
           },
           "GET /misc/oneyearcontractterms" : {
              "description" : "Get the (static for a day) terms for a one year payment contract. Use text/plain content-type to get the plain text version instead of a JSON-encoded version.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/misc/oneyearcontractterms"
           },
           "GET /misc/singleappointmentcontractterms" : {
              "description" : "Get the (static for a day) terms for a one year payment contract. Use text/plain content-type to get the plain text version instead of a JSON-encoded version.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/misc/singleappointmentcontractterms"
           },
           "POST /patients/{patientid}/collectpayment" : {
              "description" : "Accepts a payment from a patient. Please note that if swipe information (trackdata) is not supplied and credit card information is entered manually, then several other fields are required. See the documentation below for more details.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "accountnumber" : {
                    "default" : "",
                    "description" : "The account number of the credit card.  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "amount" : {
                    "default" : "",
                    "description" : "DEPRECATED: Please use \"otheramount\".",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The ID of the appointment where the copay should be applied.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "billingaddress" : {
                    "default" : "",
                    "description" : "The billing address for the credit card.  (Required if track data is not supplied.)  If more than 20 characters, please truncate. (Max length: 20)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "billingzip" : {
                    "default" : "",
                    "description" : "The billing zipcode for the credit card.  (Required if track data is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "cardsecuritycode" : {
                    "default" : "",
                    "description" : "The CVV2: the 3 (or 4 for Amex) digit value normally found on the back (or front for Amex) of the credit card. This is required for ecommerce mode payments.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "claimpayment" : {
                    "default" : "",
                    "description" : "A JSON representation of claim ID and payment combinations.  For example, '[ { 1 => 1.00 }, { 2 => 5.00 } ].'  This indicates a payment of $1 for claim ID #1 and a payment of $5 for claim ID #2.",
                    "location" : "body",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "copayamount" : {
                    "default" : "",
                    "description" : "The amount associated with a particular appointment for a copay.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the payment or contract is being collected.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "ecommercemode" : {
                    "default" : "",
                    "description" : "Use ECommerce credit card mode (e.g. for telemedicine). trackdata may NOT be used if this mode is true.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "expirationmonthmm" : {
                    "default" : "",
                    "description" : "The month the credit card expires (MM).  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "expirationyearyyyy" : {
                    "default" : "",
                    "description" : "The year the credit card expires (YYYY).  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "nameoncard" : {
                    "default" : "",
                    "description" : "The name on the credit card.  (Required if trackdata is not supplied; track 2 does NOT supply name.)  Please truncate at 30 characters. (Max length: 30)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "otheramount" : {
                    "default" : "",
                    "description" : "The amount being collected that is not associated with individual appointment. This money goes into the \"unapplied\" bucket. In the future, these payments will be able to be broken down by individual claim level. Co-pay amounts should be in \"copayamount\".",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "todayservice" : {
                    "default" : "",
                    "description" : "Apply the other amount value to today's service.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "N",
                       "Y"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "trackdata" : {
                    "default" : "",
                    "description" : "The track data obtained from the credit card swipe. This can be track1 and/or track2 data. In either case, please including the start and end sentinels. (\"%\" and \"?\" for track1 and \";\" and \"?\" for track2.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/collectpayment"
           },
           "GET /patients/{patientid}/collectpayment/oneyear" : {
              "description" : "Return any contracts currently on file.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the payment or contract is being collected. This parameter is currently not formally required. However, it will be in a future patch so it is highly recommended that this parameter is used.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/collectpayment/oneyear"
           },
           "GET /patients/{patientid}/collectpayment/oneyear/{appointmentid}" : {
              "description" : "Return any contracts currently on file.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the payment or contract is being collected. This parameter is currently not formally required. However, it will be in a future patch so it is highly recommended that this parameter is used.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/collectpayment/oneyear/:appointmentid"
           },
           "POST /patients/{patientid}/collectpayment/oneyear/{appointmentid}" : {
              "description" : "Store this card in order to charge this card in the future. Please note that if swipe information (trackdata) is not supplied and credit card information is entered manually, then several other fields are required. See the documentation below for more details.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "accountnumber" : {
                    "default" : "",
                    "description" : "The account number of the credit card.  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The ID of the appointment where the copay should be applied.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "billingaddress" : {
                    "default" : "",
                    "description" : "The billing address for the credit card. (Max length: 20)",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "billingzip" : {
                    "default" : "",
                    "description" : "The billing zipcode for the credit card.",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "cardsecuritycode" : {
                    "default" : "",
                    "description" : "The CVV2: the 3 (or 4 for Amex) digit value normally found on the back (or front for Amex) of the credit card.  When creating contracts, this is required if using accountnumber instead of track data.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "claimpayment" : {
                    "default" : "",
                    "description" : "A JSON representation of claim ID and payment combinations.  For example, '[ { 1 => 1.00 }, { 2 => 5.00 } ].'  This indicates a payment of $1 for claim ID #1 and a payment of $5 for claim ID #2.",
                    "location" : "body",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the payment or contract is being collected.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "ecommercemode" : {
                    "default" : "",
                    "description" : "Use ECommerce credit card mode (e.g. for telemedicine). trackdata may NOT be used if this mode is true.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "email" : {
                    "default" : "",
                    "description" : "The email address of the patient. This is the email that the notification that the charge is about to happen and the receipt afterwards will be emailed to.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "expirationmonthmm" : {
                    "default" : "",
                    "description" : "The month the credit card expires (MM).  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "expirationyearyyyy" : {
                    "default" : "",
                    "description" : "The year the credit card expires (YYYY).  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "maxamount" : {
                    "default" : "",
                    "description" : "The maximum amount that will be charged when remittance information is received.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "nameoncard" : {
                    "default" : "",
                    "description" : "The name on the credit card.  (Required if trackdata is not supplied; track 2 does NOT supply name.)  Please truncate at 30 characters. (Max length: 30)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "todayservice" : {
                    "default" : "",
                    "description" : "Apply the other amount value to today's service.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "N",
                       "Y"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "trackdata" : {
                    "default" : "",
                    "description" : "The track data obtained from the credit card swipe. This can be track1 and/or track2 data. In either case, please including the start and end sentinels. (\"%\" and \"?\" for track1 and \";\" and \"?\" for track2.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/collectpayment/oneyear/:appointmentid"
           },
           "POST /patients/{patientid}/collectpayment/paymentplan" : {
              "description" : "Create a payment plan for the patient.  If payment is to be made via a credit card please supply appropriate credit card fields.  The payment plan can be found in the response of GET /patients/{patientid}/collectpayment/oneyear.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "accountnumber" : {
                    "default" : "",
                    "description" : "The account number of the credit card.  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The ID of the appointment where the copay should be applied.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "billingaddress" : {
                    "default" : "",
                    "description" : "The billing address for the credit card.  (Required if track data is not supplied.)  If more than 20 characters, please truncate. (Max length: 20)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "billingmethod" : {
                    "default" : "",
                    "description" : "Valid values are SENDSTATEMENTS or CREDITCARD.",
                    "enum" : [
                       "",
                       "CREDITCARD",
                       "SENDSTATEMENTS"
                    ],
                    "enumDescriptions" : [
                       "",
                       "CREDITCARD",
                       "SENDSTATEMENTS"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "billingzip" : {
                    "default" : "",
                    "description" : "The billing zipcode for the credit card.  (Required if track data is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "cardsecuritycode" : {
                    "default" : "",
                    "description" : "The CVV2: the 3 (or 4 for Amex) digit value normally found on the back (or front for Amex) of the credit card.  When creating contracts, this is required if using accountnumber instead of track data.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "claimids" : {
                    "default" : "",
                    "description" : "One or more claim IDs.",
                    "location" : "body",
                    "required" : true,
                    "type" : "array"
                 },
                 "cycleamount" : {
                    "default" : "",
                    "description" : "The amount the patient is to be billed per cycle.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the payment or contract is being collected.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "downpaymentamount" : {
                    "default" : "",
                    "description" : "Down payment to be billed.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "ecommercemode" : {
                    "default" : "",
                    "description" : "Use ECommerce credit card mode (e.g. for telemedicine). trackdata may NOT be used if this mode is true.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "email" : {
                    "default" : "",
                    "description" : "The email address of the patient",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "expirationmonthmm" : {
                    "default" : "",
                    "description" : "The month the credit card expires (MM).  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "expirationyearyyyy" : {
                    "default" : "",
                    "description" : "The year the credit card expires (YYYY).  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "frequency" : {
                    "default" : "",
                    "description" : "How often should the patient be billed (ONETIMEON - One-time charge, WEEKLY - Weekly, BIWEEKLY - Every two weeks, TWICEAMONTH - First and fifteenth of month, MONTHLY - Monthly, MONTHLYFIRSTBUSDAY - Monthly, first business day, MONTHLYLASTBUSDAY - Monthly, last business day).",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "nameoncard" : {
                    "default" : "",
                    "description" : "The name on the credit card.  (Required if trackdata is not supplied; track 2 does NOT supply name.)  Please truncate at 30 characters. (Max length: 30)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "paymentplanname" : {
                    "default" : "",
                    "description" : "The name of the payment plan.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "percentage" : {
                    "default" : "",
                    "description" : "The percentage of the current outstanding balance that the patient should be billed each period.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "startdate" : {
                    "default" : "",
                    "description" : "The date the plan should start. Defaulted to tomorrow. If you set something to start today, it will NOT get billed today; it will be billed on the same day one month from today. Future payments of credit card plans will be billed on the same day of the month as the start date. For example, if the start date is 01/15, then the credit card will be billed for the second time on 02/15.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "todayservice" : {
                    "default" : "",
                    "description" : "Apply the other amount value to today's service.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "N",
                       "Y"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "trackdata" : {
                    "default" : "",
                    "description" : "The track data obtained from the credit card swipe. This can be track1 and/or track2 data. In either case, please including the start and end sentinels. (\"%\" and \"?\" for track1 and \";\" and \"?\" for track2.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/collectpayment/paymentplan"
           },
           "GET /patients/{patientid}/collectpayment/singleappointment" : {
              "description" : "Return any contracts currently on file.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the payment or contract is being collected. This parameter is currently not formally required. However, it will be in a future patch so it is highly recommended that this parameter is used.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/collectpayment/singleappointment"
           },
           "POST /patients/{patientid}/collectpayment/singleappointment/{appointmentid}" : {
              "description" : "Store this card in order to charge this card in the future. Please note that if swipe information (trackdata) is not supplied and credit card information is entered manually, then several other fields are required. See the documentation below for more details.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "accountnumber" : {
                    "default" : "",
                    "description" : "The account number of the credit card.  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The ID of the appointment where the copay should be applied.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "billingaddress" : {
                    "default" : "",
                    "description" : "The billing address for the credit card. (Max length: 20)",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "billingzip" : {
                    "default" : "",
                    "description" : "The billing zipcode for the credit card.",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "cardsecuritycode" : {
                    "default" : "",
                    "description" : "The CVV2: the 3 (or 4 for Amex) digit value normally found on the back (or front for Amex) of the credit card.  When creating contracts, this is required if using accountnumber instead of track data.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "claimpayment" : {
                    "default" : "",
                    "description" : "A JSON representation of claim ID and payment combinations.  For example, '[ { 1 => 1.00 }, { 2 => 5.00 } ].'  This indicates a payment of $1 for claim ID #1 and a payment of $5 for claim ID #2.",
                    "location" : "body",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the payment or contract is being collected.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "ecommercemode" : {
                    "default" : "",
                    "description" : "Use ECommerce credit card mode (e.g. for telemedicine). trackdata may NOT be used if this mode is true.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "email" : {
                    "default" : "",
                    "description" : "The email address of the patient. This is the email that the notification that the charge is about to happen and the receipt afterwards will be emailed to.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "expirationmonthmm" : {
                    "default" : "",
                    "description" : "The month the credit card expires (MM).  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "expirationyearyyyy" : {
                    "default" : "",
                    "description" : "The year the credit card expires (YYYY).  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "maxamount" : {
                    "default" : "",
                    "description" : "The maximum amount that will be charged when remittance information is received.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "nameoncard" : {
                    "default" : "",
                    "description" : "The name on the credit card.  (Required if trackdata is not supplied; track 2 does NOT supply name.)  Please truncate at 30 characters. (Max length: 30)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "todayservice" : {
                    "default" : "",
                    "description" : "Apply the other amount value to today's service.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "N",
                       "Y"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "trackdata" : {
                    "default" : "",
                    "description" : "The track data obtained from the credit card swipe. This can be track1 and/or track2 data. In either case, please including the start and end sentinels. (\"%\" and \"?\" for track1 and \";\" and \"?\" for track2.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/collectpayment/singleappointment/:appointmentid"
           },
           "GET /patients/{patientid}/collectpayment/storedcard" : {
              "description" : "Return any contracts currently on file.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the payment or contract is being collected. This parameter is currently not formally required. However, it will be in a future patch so it is highly recommended that this parameter is used.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/collectpayment/storedcard"
           },
           "POST /patients/{patientid}/collectpayment/storedcard" : {
              "description" : "Store this card in order to charge this card in the future. Please note that if swipe information (trackdata) is not supplied and credit card information is entered manually, then several other fields are required. See the documentation below for more details.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "accountnumber" : {
                    "default" : "",
                    "description" : "The account number of the credit card.  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The ID of the appointment where the copay should be applied.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "billingaddress" : {
                    "default" : "",
                    "description" : "The billing address for the credit card. (Max length: 20)",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "billingzip" : {
                    "default" : "",
                    "description" : "The billing zipcode for the credit card.",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "cardsecuritycode" : {
                    "default" : "",
                    "description" : "The CVV2: the 3 (or 4 for Amex) digit value normally found on the back (or front for Amex) of the credit card.  When creating contracts, this is required if using accountnumber instead of track data.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "claimpayment" : {
                    "default" : "",
                    "description" : "A JSON representation of claim ID and payment combinations.  For example, '[ { 1 => 1.00 }, { 2 => 5.00 } ].'  This indicates a payment of $1 for claim ID #1 and a payment of $5 for claim ID #2.",
                    "location" : "body",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the payment or contract is being collected.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "ecommercemode" : {
                    "default" : "",
                    "description" : "Use ECommerce credit card mode (e.g. for telemedicine). trackdata may NOT be used if this mode is true.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "expirationmonthmm" : {
                    "default" : "",
                    "description" : "The month the credit card expires (MM).  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "expirationyearyyyy" : {
                    "default" : "",
                    "description" : "The year the credit card expires (YYYY).  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "nameoncard" : {
                    "default" : "",
                    "description" : "The name on the credit card.  (Required if trackdata is not supplied; track 2 does NOT supply name.)  Please truncate at 30 characters. (Max length: 30)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "todayservice" : {
                    "default" : "",
                    "description" : "Apply the other amount value to today's service.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "N",
                       "Y"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "trackdata" : {
                    "default" : "",
                    "description" : "The track data obtained from the credit card swipe. This can be track1 and/or track2 data. In either case, please including the start and end sentinels. (\"%\" and \"?\" for track1 and \";\" and \"?\" for track2.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/collectpayment/storedcard"
           },
           "POST /patients/{patientid}/collectpayment/storedcard/{storedcardid}" : {
              "description" : "Accepts a payment from a patient. Please note that if swipe information (trackdata) is not supplied and credit card information is entered manually, then several other fields are required. See the documentation below for more details.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":storedcardid" : {
                    "default" : null,
                    "description" : "storedcardid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "accountnumber" : {
                    "default" : "",
                    "description" : "The account number of the credit card.  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "amount" : {
                    "default" : "",
                    "description" : "DEPRECATED: Please use \"otheramount\".",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The ID of the appointment where the copay should be applied.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "billingaddress" : {
                    "default" : "",
                    "description" : "The billing address for the credit card.  (Required if track data is not supplied.)  If more than 20 characters, please truncate. (Max length: 20)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "billingzip" : {
                    "default" : "",
                    "description" : "The billing zipcode for the credit card.  (Required if track data is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "cardsecuritycode" : {
                    "default" : "",
                    "description" : "The CVV2: the 3 (or 4 for Amex) digit value normally found on the back (or front for Amex) of the credit card. This is required for ecommerce mode payments.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "claimpayment" : {
                    "default" : "",
                    "description" : "A JSON representation of claim ID and payment combinations.  For example, '[ { 1 => 1.00 }, { 2 => 5.00 } ].'  This indicates a payment of $1 for claim ID #1 and a payment of $5 for claim ID #2.",
                    "location" : "body",
                    "required" : true,
                    "type" : "textarea"
                 },
                 "copayamount" : {
                    "default" : "",
                    "description" : "The amount associated with a particular appointment for a copay.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the payment or contract is being collected.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "ecommercemode" : {
                    "default" : "",
                    "description" : "Use ECommerce credit card mode (e.g. for telemedicine). trackdata may NOT be used if this mode is true.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "expirationmonthmm" : {
                    "default" : "",
                    "description" : "The month the credit card expires (MM).  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "expirationyearyyyy" : {
                    "default" : "",
                    "description" : "The year the credit card expires (YYYY).  (Required if trackdata is not supplied.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "nameoncard" : {
                    "default" : "",
                    "description" : "The name on the credit card.  (Required if trackdata is not supplied; track 2 does NOT supply name.)  Please truncate at 30 characters. (Max length: 30)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "otheramount" : {
                    "default" : "",
                    "description" : "The amount being collected that is not associated with individual appointment. This money goes into the \"unapplied\" bucket. In the future, these payments will be able to be broken down by individual claim level. Co-pay amounts should be in \"copayamount\".",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "todayservice" : {
                    "default" : "",
                    "description" : "Apply the other amount value to today's service.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "N",
                       "Y"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "trackdata" : {
                    "default" : "",
                    "description" : "The track data obtained from the credit card swipe. This can be track1 and/or track2 data. In either case, please including the start and end sentinels. (\"%\" and \"?\" for track1 and \";\" and \"?\" for track2.)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/collectpayment/storedcard/:storedcardid"
           },
           "PUT /patients/{patientid}/collectpayment/storedcard/{storedcardid}" : {
              "description" : "Accepts a payment from a patient. Please note that if swipe information (trackdata) is not supplied and credit card information is entered manually, then several other fields are required. See the documentation below for more details.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":storedcardid" : {
                    "default" : null,
                    "description" : "storedcardid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "accountnumber" : {
                    "default" : "",
                    "description" : "The account number of the credit card.  (Required if trackdata is not supplied.)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "amount" : {
                    "default" : "",
                    "description" : "DEPRECATED: Please use \"otheramount\".",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The ID of the appointment where the copay should be applied.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "billingaddress" : {
                    "default" : "",
                    "description" : "The billing address for the credit card.  (Required if track data is not supplied.)  If more than 20 characters, please truncate. (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "billingzip" : {
                    "default" : "",
                    "description" : "The billing zipcode for the credit card.  (Required if track data is not supplied.)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "cardsecuritycode" : {
                    "default" : "",
                    "description" : "The CVV2: the 3 (or 4 for Amex) digit value normally found on the back (or front for Amex) of the credit card. This is required for ecommerce mode payments.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "claimpayment" : {
                    "default" : "",
                    "description" : "A JSON representation of claim ID and payment combinations.  For example, '[ { 1 => 1.00 }, { 2 => 5.00 } ].'  This indicates a payment of $1 for claim ID #1 and a payment of $5 for claim ID #2.",
                    "location" : "query",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "copayamount" : {
                    "default" : "",
                    "description" : "The amount associated with a particular appointment for a copay.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the payment or contract is being collected.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "ecommercemode" : {
                    "default" : "",
                    "description" : "Use ECommerce credit card mode (e.g. for telemedicine). trackdata may NOT be used if this mode is true.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "expirationmonthmm" : {
                    "default" : "",
                    "description" : "The month the credit card expires (MM).  (Required if trackdata is not supplied.)",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "expirationyearyyyy" : {
                    "default" : "",
                    "description" : "The year the credit card expires (YYYY).  (Required if trackdata is not supplied.)",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "nameoncard" : {
                    "default" : "",
                    "description" : "The name on the credit card.  (Required if trackdata is not supplied; track 2 does NOT supply name.)  Please truncate at 30 characters. (Max length: 30)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "otheramount" : {
                    "default" : "",
                    "description" : "The amount being collected that is not associated with individual appointment. This money goes into the \"unapplied\" bucket. In the future, these payments will be able to be broken down by individual claim level. Co-pay amounts should be in \"copayamount\".",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "preferredcard" : {
                    "default" : "",
                    "description" : "Flag to make a STOREDCARD contract the default one for the patient",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "todayservice" : {
                    "default" : "",
                    "description" : "Apply the other amount value to today's service.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "N",
                       "Y"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "trackdata" : {
                    "default" : "",
                    "description" : "The track data obtained from the credit card swipe. This can be track1 and/or track2 data. In either case, please including the start and end sentinels. (\"%\" and \"?\" for track1 and \";\" and \"?\" for track2.)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/collectpayment/storedcard/:storedcardid"
           },
           "DELETE /patients/{patientid}/collectpayment/storedcard/{storedcardid}" : {
              "description" : "Accepts a payment from a patient. Please note that if swipe information (trackdata) is not supplied and credit card information is entered manually, then several other fields are required. See the documentation below for more details.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":storedcardid" : {
                    "default" : null,
                    "description" : "storedcardid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "accountnumber" : {
                    "default" : "",
                    "description" : "The account number of the credit card.  (Required if trackdata is not supplied.)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "amount" : {
                    "default" : "",
                    "description" : "DEPRECATED: Please use \"otheramount\".",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The ID of the appointment where the copay should be applied.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "billingaddress" : {
                    "default" : "",
                    "description" : "The billing address for the credit card.  (Required if track data is not supplied.)  If more than 20 characters, please truncate. (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "billingzip" : {
                    "default" : "",
                    "description" : "The billing zipcode for the credit card.  (Required if track data is not supplied.)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "cardsecuritycode" : {
                    "default" : "",
                    "description" : "The CVV2: the 3 (or 4 for Amex) digit value normally found on the back (or front for Amex) of the credit card. This is required for ecommerce mode payments.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "claimpayment" : {
                    "default" : "",
                    "description" : "A JSON representation of claim ID and payment combinations.  For example, '[ { 1 => 1.00 }, { 2 => 5.00 } ].'  This indicates a payment of $1 for claim ID #1 and a payment of $5 for claim ID #2.",
                    "location" : "query",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "copayamount" : {
                    "default" : "",
                    "description" : "The amount associated with a particular appointment for a copay.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the payment or contract is being collected.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "ecommercemode" : {
                    "default" : "",
                    "description" : "Use ECommerce credit card mode (e.g. for telemedicine). trackdata may NOT be used if this mode is true.",
                    "enum" : [
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "expirationmonthmm" : {
                    "default" : "",
                    "description" : "The month the credit card expires (MM).  (Required if trackdata is not supplied.)",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "expirationyearyyyy" : {
                    "default" : "",
                    "description" : "The year the credit card expires (YYYY).  (Required if trackdata is not supplied.)",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "nameoncard" : {
                    "default" : "",
                    "description" : "The name on the credit card.  (Required if trackdata is not supplied; track 2 does NOT supply name.)  Please truncate at 30 characters. (Max length: 30)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "otheramount" : {
                    "default" : "",
                    "description" : "The amount being collected that is not associated with individual appointment. This money goes into the \"unapplied\" bucket. In the future, these payments will be able to be broken down by individual claim level. Co-pay amounts should be in \"copayamount\".",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "todayservice" : {
                    "default" : "",
                    "description" : "Apply the other amount value to today's service.",
                    "enum" : [
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "N",
                       "Y"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "trackdata" : {
                    "default" : "",
                    "description" : "The track data obtained from the credit card swipe. This can be track1 and/or track2 data. In either case, please including the start and end sentinels. (\"%\" and \"?\" for track1 and \";\" and \"?\" for track2.)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/collectpayment/storedcard/:storedcardid"
           },
           "GET /patients/{patientid}/insurances" : {
              "description" : "Returns a list of insurance packages for a patient.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/insurances"
           },
           "POST /patients/{patientid}/insurances" : {
              "description" : "POST creates a new insurance policy.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "insuranceidnumber" : {
                    "default" : "",
                    "description" : "The insurance policy ID number (as presented on the insurance card itself).",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepackageid" : {
                    "default" : "",
                    "description" : "The athena insurance package ID.",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "insurancephone" : {
                    "default" : "",
                    "description" : "The phone number for the insurance company. Note: This defaults to the insurance package phone number. If this is set, it will override it. Likewise if blanked out, it will go back to default.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderaddress1" : {
                    "default" : "",
                    "description" : "The first address line of the insurance policy holder.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderaddress2" : {
                    "default" : "",
                    "description" : "The second address line of the insurance policy holder.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholdercity" : {
                    "default" : "",
                    "description" : "The city of the insurance policy holder.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholdercountrycode" : {
                    "default" : "",
                    "description" : "The country code (3 letter) of the insurance policy holder.  Either this or insurancepolicyholdercountryiso3166 are acceptable.  Defaults to USA.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholdercountryiso3166" : {
                    "default" : "",
                    "description" : "The [ISO 3166](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the insurance policy holder.  Either this or insurancepolicyholdercountrycode are acceptable.  Defaults to US",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderdob" : {
                    "default" : "",
                    "description" : "The DOB of the insurance policy holder (mm/dd/yyyy).",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderfirstname" : {
                    "default" : "",
                    "description" : "The first name of the insurance policy holder.  Except for self-pay, required for new policies.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderlastname" : {
                    "default" : "",
                    "description" : "The last name of the insurance policy holder.  Except for self-pay, required for new policies.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholdermiddlename" : {
                    "default" : "",
                    "description" : "The middle name of the insurance policy holder.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholdersex" : {
                    "default" : "",
                    "description" : "The sex of the insurance policy holder.  Except for self-pay, required for new policies.",
                    "enum" : [
                       "",
                       "F",
                       "M"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Female",
                       "Male"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderssn" : {
                    "default" : "",
                    "description" : "The SSN of the insurance policy holder.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderstate" : {
                    "default" : "",
                    "description" : "The state of the insurance policy holder.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholdersuffix" : {
                    "default" : "",
                    "description" : "The suffix of the insurance policy holder.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderzip" : {
                    "default" : "",
                    "description" : "The zip of the insurance policy holder.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "policynumber" : {
                    "default" : "",
                    "description" : "The insurance group number.  This is sometimes present on an insurance card.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "relationshiptoinsuredid" : {
                    "default" : "",
                    "description" : "This patient's relationship to the policy holder (as an ID).  See [the mapping](/docs/read/reference/Patient_Relationship_Mapping).",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "sequencenumber" : {
                    "default" : "",
                    "description" : "1 = primary, 2 = secondary.  Must have a primary before a secondary.",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "updateappointments" : {
                    "default" : "",
                    "description" : "If set to true, automatically updates all future appointments to this insurance.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/insurances"
           },
           "PUT /patients/{patientid}/insurances" : {
              "description" : "PUT will update an insurance, but the insurance package ID can't be changed.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "insuranceidnumber" : {
                    "default" : "",
                    "description" : "The insurance policy ID number (as presented on the insurance card itself).",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancephone" : {
                    "default" : "",
                    "description" : "The phone number for the insurance company. Note: This defaults to the insurance package phone number. If this is set, it will override it. Likewise if blanked out, it will go back to default.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderaddress1" : {
                    "default" : "",
                    "description" : "The first address line of the insurance policy holder.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderaddress2" : {
                    "default" : "",
                    "description" : "The second address line of the insurance policy holder.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholdercity" : {
                    "default" : "",
                    "description" : "The city of the insurance policy holder.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholdercountrycode" : {
                    "default" : "",
                    "description" : "The country code (3 letter) of the insurance policy holder.  Either this or insurancepolicyholdercountryiso3166 are acceptable.  Defaults to USA.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholdercountryiso3166" : {
                    "default" : "",
                    "description" : "The [ISO 3166](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the insurance policy holder.  Either this or insurancepolicyholdercountrycode are acceptable.  Defaults to US",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderdob" : {
                    "default" : "",
                    "description" : "The DOB of the insurance policy holder (mm/dd/yyyy).",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderfirstname" : {
                    "default" : "",
                    "description" : "The first name of the insurance policy holder.  Except for self-pay, required for new policies.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderlastname" : {
                    "default" : "",
                    "description" : "The last name of the insurance policy holder.  Except for self-pay, required for new policies.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholdermiddlename" : {
                    "default" : "",
                    "description" : "The middle name of the insurance policy holder.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholdersex" : {
                    "default" : "",
                    "description" : "The sex of the insurance policy holder.  Except for self-pay, required for new policies.",
                    "enum" : [
                       "",
                       "F",
                       "M"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Female",
                       "Male"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderssn" : {
                    "default" : "",
                    "description" : "The SSN of the insurance policy holder.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderstate" : {
                    "default" : "",
                    "description" : "The state of the insurance policy holder.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholdersuffix" : {
                    "default" : "",
                    "description" : "The suffix of the insurance policy holder.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "insurancepolicyholderzip" : {
                    "default" : "",
                    "description" : "The zip of the insurance policy holder.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "policynumber" : {
                    "default" : "",
                    "description" : "The insurance group number.  This is sometimes present on an insurance card.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "relationshiptoinsuredid" : {
                    "default" : "",
                    "description" : "This patient's relationship to the policy holder (as an ID).  See [the mapping](/docs/read/reference/Patient_Relationship_Mapping).",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "sequencenumber" : {
                    "default" : "",
                    "description" : "1 = primary, 2 = secondary.  Must have a primary before a secondary.",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "updateappointments" : {
                    "default" : "",
                    "description" : "If set to true, automatically updates all future appointments to this insurance.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/insurances"
           },
           "DELETE /patients/{patientid}/insurances" : {
              "description" : "DELETE deactivates an insurance package.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "cancellationnote" : {
                    "default" : "",
                    "description" : "Optional note as to why this is being cancelled.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "sequencenumber" : {
                    "default" : "",
                    "description" : "1 = primary, 2 = secondary.",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/insurances"
           },
           "GET /patients/{patientid}/insurances/{insuranceid}/image" : {
              "description" : "Gets the patient's insurance card image. You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additional information.\n\ncurl -H \"Authorization: Bearer {Authorization Token}\" -X GET \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/insurances/{insuranceid}/image?jpegoutput={true|false}\"",
              "httpMethod" : "GET",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":insuranceid" : {
                    "default" : null,
                    "description" : "insuranceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "jpegoutput" : {
                    "default" : "",
                    "description" : "If set to true, or if Accept header is image/jpeg, returns the image directly.  (The image may be scaled.)",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/insurances/:insuranceid/image"
           },
           "POST /patients/{patientid}/insurances/{insuranceid}/image" : {
              "description" : "PUT/POST are the same and update a patient's insurance card image. You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additional information.\n\ncurl -H \"Authorization: Bearer {Authorization Token}\" -F \"image=@{Path to image file}\" \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/insurances/{insuranceid}/image\"",
              "httpMethod" : "POST",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":insuranceid" : {
                    "default" : null,
                    "description" : "insuranceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "multipart/form-data",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID associated with this upload.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "image" : {
                    "default" : "",
                    "description" : "Base64 encoded image, or, if multipart/form-data, unencoded image. This image may be scaled down after submission. PUT is not recommended when using multipart/form-data. Since POST and PUT have identical functionality, POST is recommended.",
                    "location" : "body",
                    "required" : true,
                    "type" : "file"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/insurances/:insuranceid/image"
           },
           "PUT /patients/{patientid}/insurances/{insuranceid}/image" : {
              "description" : "PUT/POST are the same and update a patient's insurance card image. You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additional information.\n\ncurl -H \"Authorization: Bearer {Authorization Token}\" -F \"image=@{Path to image file}\" \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/insurances/{insuranceid}/image\"",
              "httpMethod" : "PUT",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":insuranceid" : {
                    "default" : null,
                    "description" : "insuranceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "multipart/form-data",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID associated with this upload.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "image" : {
                    "default" : "",
                    "description" : "Base64 encoded image, or, if multipart/form-data, unencoded image. This image may be scaled down after submission. PUT is not recommended when using multipart/form-data. Since POST and PUT have identical functionality, POST is recommended.",
                    "location" : "query",
                    "required" : true,
                    "type" : "file"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/insurances/:insuranceid/image"
           },
           "DELETE /patients/{patientid}/insurances/{insuranceid}/image" : {
              "description" : "Deletes a patient's insurance card image.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":insuranceid" : {
                    "default" : null,
                    "description" : "insuranceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/insurances/:insuranceid/image"
           },
           "GET /patients/{patientid}/receipts" : {
              "description" : "Retieve a list of epayment IDs for a given patient.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID for the receipts you are looking for.",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/receipts"
           },
           "GET /patients/{patientid}/receipts/{epaymentid}" : {
              "description" : "Retrieve a copy of a patient receipt. An Accept header of text/html or application/pdf or image/jpg will send back the raw, non-JSON-encoded output in the appropriate format. Otherwise, the HTML is returned inside of \"receipthtml\". The epaymentid is returned from a previous call to /patients/{patientid}/collectpayment or other payment methods.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":epaymentid" : {
                    "default" : null,
                    "description" : "epaymentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "customerversion" : {
                    "default" : "",
                    "description" : "If true, returns the customer (patient) version of the receipt.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "merchantversion" : {
                    "default" : "",
                    "description" : "If true, returns the merchant version of the receipt.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/receipts/:epaymentid"
           },
           "GET /patients/{patientid}/receipts/{epaymentid}/details" : {
              "description" : "The details of the patient receipt as a JSON object.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":epaymentid" : {
                    "default" : null,
                    "description" : "epaymentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/receipts/:epaymentid/details"
           },
           "POST /patients/{patientid}/receipts/{epaymentid}/email" : {
              "description" : "Email a copy of the credit card receipt to an email recipient. Generally, this action is initiated by a patient (e.g. as part of Digital Check-In).",
              "httpMethod" : "POST",
              "parameters" : {
                 ":epaymentid" : {
                    "default" : null,
                    "description" : "epaymentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "email" : {
                    "default" : "",
                    "description" : "The email address to send to.",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/receipts/:epaymentid/email"
           },
           "GET /patients/{patientid}/receipts/{epaymentid}/signed" : {
              "description" : "Returns a PDF of the signed receipt image, if available. You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additonal information.\n\ncurl -H \"Authorization: Bearer {Authorization Key}\" -X GET \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/receipts/{epaymentid}/signed\"",
              "httpMethod" : "GET",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":epaymentid" : {
                    "default" : null,
                    "description" : "epaymentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/receipts/:epaymentid/signed"
           },
           "POST /patients/{patientid}/receipts/{epaymentid}/signed" : {
              "description" : "Upload a signed receipt/contract (via multipart/form-data). You can use cURL to test file uploads and downloads. Replace the curly-brace variables in the following cURL command with your actual values to test this call. See [File Upload Suggestions](https://developer.athenahealth.com/docs/read/reference/File_Upload_Suggestions) for additional information.\n\ncurl -H \"Authorization: Bearer {Authorization Key}\" -F \"attachmentcontents={Path to image file}\" \"https://api.athenahealth.com/preview1/{practiceid}/patients/{patientid}/receipts/{epaymentid}/signed\"",
              "httpMethod" : "POST",
              "parameters" : {
                 "::disable-in-iodocs::" : {
                    "description" : "meta-field used as a hook"
                 },
                 ":epaymentid" : {
                    "default" : null,
                    "description" : "epaymentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "multipart/form-data",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "attachmentcontents" : {
                    "default" : "",
                    "description" : "The PDF of the signed receipt. This implies that this is a multipart/form-data content type. This does NOT work correctly in I/O Docs. The filename itself is not used by athenaNet.",
                    "location" : "body",
                    "required" : true,
                    "type" : "file"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/receipts/:epaymentid/signed"
           },
           "POST /patients/{patientid}/recordpayment" : {
              "description" : "Accepts data related to a cash or check patient payment.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "appointmentid" : {
                    "default" : "",
                    "description" : "The ID of the appointment where the copay should be applied.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "checknumber" : {
                    "default" : "",
                    "description" : "The check number.  This is required if the payment is made by check.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "claimpayment" : {
                    "default" : "",
                    "description" : "A JSON representation of claim ID and payment combinations.  For example, '[ { 1 => 1.00 }, { 2 => 5.00 } ].'  This indicates a payment of $1 for claim ID #1 and a payment of $5 for claim ID #2.",
                    "location" : "body",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "copayamount" : {
                    "default" : "",
                    "description" : "The amount associated with a particular appointment for a copay.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the payment or contract is being collected.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "otheramount" : {
                    "default" : "",
                    "description" : "The amount being collected that is not associated with individual appointment. This money goes into the \"unapplied\" bucket. In the future, these payments will be able to be broken down by individual claim level. Co-pay amounts should be in \"copayamount\".",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "paymentmethod" : {
                    "default" : "",
                    "description" : "Valid values include CASH or CHECK.",
                    "enum" : [
                       "CASH",
                       "CHECK"
                    ],
                    "enumDescriptions" : [
                       "CASH",
                       "CHECK"
                    ],
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "postdate" : {
                    "default" : "",
                    "description" : "The date the payment was made.  Defaulted to today.",
                    "format" : "date",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "todayservice" : {
                    "default" : "",
                    "description" : "Apply the other amount value to today's service.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "N",
                       "Y"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/recordpayment"
           },
           "GET /patients/{patientid}/referralauths" : {
              "description" : "Retrieves the list of authorizations and referrals for a given patient.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "insuranceid" : {
                    "default" : "",
                    "description" : "The insurance ID.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showexpired" : {
                    "default" : "",
                    "description" : "If set, results will include expired authorizations/referrals. This defaults to false.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/referralauths"
           },
           "POST /patients/{patientid}/voidpayment/{epaymentid}" : {
              "description" : "Void an individual payment from an epayment ID.  This only works from the time of the payment to the time it is settled, generally around 8 p.m. Eastern time nightly.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":epaymentid" : {
                    "default" : null,
                    "description" : "epaymentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/voidpayment/:epaymentid"
           }
        }
     },
     "Patients" : {
        "methods" : {
           "GET /patients" : {
              "description" : "Find a patient.  At least one of the following is required: guarantorfirstname, firstname, dob, workphone, departmentid, guarantorsuffix, guarantorlastname, mobilephone, middlename, suffix, guarantormiddlename, homephone, lastname.  Upcoming appointment information may also be provided to further restrict the match.  Please note that GET /patients is flexible. As with all API calls, please be sure your use complies with applicable law, including HIPAA.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "address1" : {
                    "default" : "",
                    "description" : "Patient's address - 1st line (Max length: 100)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "address2" : {
                    "default" : "",
                    "description" : "Patient's address - 2nd line (Max length: 100)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "agriculturalworker" : {
                    "default" : "",
                    "description" : "Used to identify this patient as an agricultural worker. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "agriculturalworkertype" : {
                    "default" : "",
                    "description" : "For patients that are agricultural workers, identifies the type of worker. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "MIGRANT",
                       "SEASONAL",
                       "UNSPECIFIED"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "Migrant",
                       "Seasonal",
                       "Unspecified"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "anyphone" : {
                    "default" : "",
                    "description" : "Any phone number for the patient.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients.  You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "appointmentdepartmentid" : {
                    "default" : "",
                    "description" : "The ID of the department associated with the upcoming appointment.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "appointmentproviderid" : {
                    "default" : "",
                    "description" : "The ID of the provider associated with the upcoming appointment.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "caresummarydeliverypreference" : {
                    "default" : "",
                    "description" : "The patient's preference for care summary delivery.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "city" : {
                    "default" : "",
                    "description" : "Patient's city (Max length: 30)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "clinicalordertypegroupid" : {
                    "default" : "",
                    "description" : "The clinical order type group of the clinical provider (Prescription: 10, Lab: 11, Vaccinations: 16).",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "consenttocall" : {
                    "default" : "",
                    "description" : "The flag is used to record the consent of a patient to receive automated calls and text messages per FCC requirements. The requested legal language is 'Entry of any telephone contact number constitutes written consent to receive any automated, prerecorded, and artificial voice telephone calls initiated by the Practice. To alter or revoke this consent, visit the Patient Portal \"Contact Preferences\" page.'",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contacthomephone" : {
                    "default" : "",
                    "description" : "Emergency contact home phone.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactmobilephone" : {
                    "default" : "",
                    "description" : "Emergency contact mobile phone.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactname" : {
                    "default" : "",
                    "description" : "The name of the (emergency) person to contact about the patient. The contactname, contactrelationship, contacthomephone, and contactmobilephone fields are all related to the emergency contact for the patient. They are NOT related to the contractpreference_* fields. (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference" : {
                    "default" : "",
                    "description" : "The MU-required field for \"preferred contact method\". This is not used by any automated systems.",
                    "enum" : [
                       "",
                       "HOMEPHONE",
                       "MAIL",
                       "MOBILEPHONE",
                       "PORTAL",
                       "WORKPHONE"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Home Phone",
                       "Mail",
                       "Mobile Phone",
                       "Portal",
                       "Work Phone"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_announcement_email" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"announcement\" communications delivered via email.  Note that this will not be present if the practice or patient has not set it.For completeness, turning email off is supported via the API, but it is discouraged. When email is off, patients may not not get messages from the patient portal.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_announcement_phone" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"announcement\" communications delivered via phone.  Note that this will not be present if the practice or patient has not set it.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_announcement_sms" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"announcement\" communications delivered via SMS.  Note that this will not be present if the practice or patient has not set it.For SMS, there is specific terms of service language that must be used when displaying this as an option to be turned on.  Turning on must be an action by the patient, not a practice user.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_appointment_email" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"appointment\" communications delivered via email.  Note that this will not be present if the practice or patient has not set it.For completeness, turning email off is supported via the API, but it is discouraged. When email is off, patients may not not get messages from the patient portal.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_appointment_phone" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"appointment\" communications delivered via phone.  Note that this will not be present if the practice or patient has not set it.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_appointment_sms" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"appointment\" communications delivered via SMS.  Note that this will not be present if the practice or patient has not set it.For SMS, there is specific terms of service language that must be used when displaying this as an option to be turned on.  Turning on must be an action by the patient, not a practice user.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_billing_email" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"billing\" communications delivered via email.  Note that this will not be present if the practice or patient has not set it.For completeness, turning email off is supported via the API, but it is discouraged. When email is off, patients may not not get messages from the patient portal.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_billing_phone" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"billing\" communications delivered via phone.  Note that this will not be present if the practice or patient has not set it.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_billing_sms" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"billing\" communications delivered via SMS.  Note that this will not be present if the practice or patient has not set it.For SMS, there is specific terms of service language that must be used when displaying this as an option to be turned on.  Turning on must be an action by the patient, not a practice user.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_lab_email" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"lab\" communications delivered via email.  Note that this will not be present if the practice or patient has not set it.For completeness, turning email off is supported via the API, but it is discouraged. When email is off, patients may not not get messages from the patient portal.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_lab_phone" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"lab\" communications delivered via phone.  Note that this will not be present if the practice or patient has not set it.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_lab_sms" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"lab\" communications delivered via SMS.  Note that this will not be present if the practice or patient has not set it.For SMS, there is specific terms of service language that must be used when displaying this as an option to be turned on.  Turning on must be an action by the patient, not a practice user.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactrelationship" : {
                    "default" : "",
                    "description" : "Emergency contact relationship (one of SPOUSE, PARENT, CHILD, SIBLING, FRIEND, COUSIN, GUARDIAN, OTHER)",
                    "enum" : [
                       "",
                       "CHILD",
                       "COUSIN",
                       "FRIEND",
                       "GUARDIAN",
                       "OTHER",
                       "PARENT",
                       "SIBLING",
                       "SPOUSE"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Child",
                       "Cousin",
                       "Friend",
                       "Guardian",
                       "Other",
                       "Parent",
                       "Sibling",
                       "Spouse"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "countrycode3166" : {
                    "default" : "",
                    "description" : "Patient's country code (ISO 3166-1) (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "deceaseddate" : {
                    "default" : "",
                    "description" : "If present, the date on which a patient died.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "defaultpharmacyncpdpid" : {
                    "default" : "",
                    "description" : "The NCPDP ID of the patient's preferred pharmacy.  See http://www.ncpdp.org/ for details. Note: if updating this field, please make sure to have a CLINICALORDERYPEGROUPID field as well.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "Primary (registration) department ID.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "dob" : {
                    "default" : "",
                    "description" : "Patient's DOB (mm/dd/yyyy)",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "email" : {
                    "default" : "",
                    "description" : "Patient's email address.  'declined' can be used to indicate just that.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "employerid" : {
                    "default" : "",
                    "description" : "The patient's employer's ID (from /employers call)",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "employerphone" : {
                    "default" : "",
                    "description" : "The patient's employer's phone number. Normally, this is set by setting employerid. However, setting this value can be used to override this on an individual patient.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "ethnicitycode" : {
                    "default" : "",
                    "description" : "Ethnicity of the patient, using the 2.16.840.1.113883.5.50 codeset. See http://www.hl7.org/implement/standards/fhir/terminologies-v3.html Special case: use \"declined\" to indicate that the patient declined to answer.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "firstname" : {
                    "default" : "",
                    "description" : "Patient's first name (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantoraddress1" : {
                    "default" : "",
                    "description" : "Guarantor's address (Max length: 100)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantoraddress2" : {
                    "default" : "",
                    "description" : "Guarantor's address - line 2 (Max length: 100)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorcity" : {
                    "default" : "",
                    "description" : "Guarantor's city (Max length: 30)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorcountrycode3166" : {
                    "default" : "US",
                    "description" : "Guarantor's country code (ISO 3166-1) (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantordob" : {
                    "default" : "",
                    "description" : "Guarantor's DOB (mm/dd/yyyy)",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantoremail" : {
                    "default" : "",
                    "description" : "Guarantor's email address",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantoremployerid" : {
                    "default" : "",
                    "description" : "The guaranror's employer's ID (from /employers call)",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "guarantorfirstname" : {
                    "default" : "",
                    "description" : "Guarantor's first name (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorlastname" : {
                    "default" : "",
                    "description" : "Guarantor's last name (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantormiddlename" : {
                    "default" : "",
                    "description" : "Guarantor's middle name (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorphone" : {
                    "default" : "",
                    "description" : "Guarantor's phone number.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorrelationshiptopatient" : {
                    "default" : "",
                    "description" : "The guarantor's relationship to the patient",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorssn" : {
                    "default" : "",
                    "description" : "Guarantor's SSN",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorstate" : {
                    "default" : "",
                    "description" : "Guarantor's state (2 letter abbreviation)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorsuffix" : {
                    "default" : "",
                    "description" : "Guarantor's name suffix (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorzip" : {
                    "default" : "",
                    "description" : "Guarantor's zip",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guardianfirstname" : {
                    "default" : "",
                    "description" : "The first name of the patient's guardian.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guardianlastname" : {
                    "default" : "",
                    "description" : "The last name of the patient's guardian.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guardianmiddlename" : {
                    "default" : "",
                    "description" : "The middle name of the patient's guardian.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guardiansuffix" : {
                    "default" : "",
                    "description" : "The suffix of the patient's guardian.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "hasmobileyn" : {
                    "default" : "",
                    "description" : "Set to false if a client has declined a phone number.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "homeboundyn" : {
                    "default" : "",
                    "description" : "If the patient is homebound, this is true.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "homeless" : {
                    "default" : "",
                    "description" : "Used to identify this patient as homeless. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "homelesstype" : {
                    "default" : "",
                    "description" : "For patients that are homeless, provides more detail regarding the patient's homeless situation. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "DOUBLINGUP",
                       "SHELTER",
                       "OTHER",
                       "STREET",
                       "TRANSITIONAL",
                       "UNSPECIFIED"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "Doubling Up",
                       "Homeless Shelter",
                       "Other",
                       "Street",
                       "Transitional",
                       "Unspecified"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "homephone" : {
                    "default" : "",
                    "description" : "The patient's home phone number.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "ignorerestrictions" : {
                    "default" : "",
                    "description" : "Set to true to allow ability to find patients with record restrictions and blocked patients. This should only be used when there is no reflection to the patient at all that a match was found or not found.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "industrycode" : {
                    "default" : "",
                    "description" : "Industry of the patient, using the US Census industry code (code system 2.16.840.1.113883.6.310).  \"other\" can be used as well.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "language6392code" : {
                    "default" : "",
                    "description" : "Language of the patient, using the ISO 639.2 code. (http://www.loc.gov/standards/iso639-2/php/code_list.php; \"T\" or terminology code) Special case: use \"declined\" to indicate that the patient declined to answer.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "lastname" : {
                    "default" : "",
                    "description" : "Patient's last name (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 10, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "maritalstatus" : {
                    "default" : "",
                    "description" : "Marital Status (D=Divorced, M=Married, S=Single, U=Unknown, W=Widowed, X=Separated, P=Partner)",
                    "enum" : [
                       "",
                       "D",
                       "M",
                       "P",
                       "X",
                       "S",
                       "U",
                       "W"
                    ],
                    "enumDescriptions" : [
                       "",
                       "DIVORCED",
                       "MARRIED",
                       "PARTNER",
                       "SEPARATED",
                       "SINGLE",
                       "UNKNOWN",
                       "WIDOWED"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "middlename" : {
                    "default" : "",
                    "description" : "Patient's middle name (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "mobilecarrierid" : {
                    "default" : "",
                    "description" : "The ID of the mobile carrier, from /mobilecarriers or the list below.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "mobilephone" : {
                    "default" : "",
                    "description" : "The patient's mobile phone number. On input, 'declined' can be used to indicate no number. (Alternatively, hasmobile can also be set to false. \"declined\" simply does this for you.)  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "nextkinname" : {
                    "default" : "",
                    "description" : "The full name of the next of kin.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "nextkinphone" : {
                    "default" : "",
                    "description" : "The next of kin phone number.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "nextkinrelationship" : {
                    "default" : "",
                    "description" : "The next of kin relationship (one of SPOUSE, PARENT, CHILD, SIBLING, FRIEND, COUSIN, GUARDIAN, OTHER)",
                    "enum" : [
                       "",
                       "CHILD",
                       "COUSIN",
                       "FRIEND",
                       "GUARDIAN",
                       "OTHER",
                       "PARENT",
                       "SIBLING",
                       "SPOUSE"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Child",
                       "Cousin",
                       "Friend",
                       "Guardian",
                       "Other",
                       "Parent",
                       "Sibling",
                       "Spouse"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "notes" : {
                    "default" : "",
                    "description" : "Notes associated with this patient.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "occupationcode" : {
                    "default" : "",
                    "description" : "Occupation of the patient, using the US Census occupation code (code system 2.16.840.1.113883.6.240).  \"other\" can be used as well.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "onlinestatementonlyyn" : {
                    "default" : "",
                    "description" : "Set to true if a patient wishes to get e-statements instead of paper statements. Should only be set for patients with an email address and clients with athenaCommunicator. The language we use in the portal is, \"Future billing statements will be sent to you securely via your Patient Portal account. You will receive an email notice when new statements are available.\" This language is not required, but it is given as a suggestion.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "portalaccessgiven" : {
                    "default" : "",
                    "description" : "This flag is set if the patient has been given access to the portal. This may be set by the API user if a patient has been given access to the portal \"by providing a preprinted brochure or flyer showing the URL where patients can access their Patient Care Summaries.\" The practiceinfo endpoint can provide the portal URL. While technically allowed, it would be very unusual to set this to false via the API.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "povertylevelfamilysize" : {
                    "default" : "",
                    "description" : "Patient's family size (used for determining poverty level). Only settable if client has Federal Poverty Level fields turned on.",
                    "location" : "query",
                    "required" : false,
                    "type" : "number"
                 },
                 "povertylevelincomepayperiod" : {
                    "default" : "",
                    "description" : "Patient's pay period (used for determining poverty level). Only settable if client has Federal Poverty Level fields turned on.",
                    "enum" : [
                       "",
                       "BIWEEK",
                       "MONTH",
                       "WEEK",
                       "YEAR"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "2 Weeks",
                       "Month",
                       "Week",
                       "Year"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "povertylevelincomeperpayperiod" : {
                    "default" : "",
                    "description" : "Patient's income per specified pay period (used for determining poverty level). Only settable if client has Federal Poverty Level fields turned on.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "preferredname" : {
                    "default" : "",
                    "description" : "The patient's preferred name (i.e. nickname).",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "primarydepartmentid" : {
                    "default" : "",
                    "description" : "The patient's \"current\" department. This field is not always set by the practice.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "primaryproviderid" : {
                    "default" : "",
                    "description" : "The \"primary\" provider for this patient, if set.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "publichousing" : {
                    "default" : "",
                    "description" : "Used to identify this patient as living in public housing. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "race" : {
                    "default" : "",
                    "description" : "The patient race, using the 2.16.840.1.113883.5.104 codeset.  See http://www.hl7.org/implement/standards/fhir/terminologies-v3.html Special case: use \"declined\" to indicate that the patient declined to answer. Multiple values or a tab-seperated list of codes is acceptable for multiple races for input.  The first race will be considered \"primary\".  Note: you must update all values at once if you update any.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "referralsourceid" : {
                    "default" : "",
                    "description" : "The referral / \"how did you hear about us\" ID.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "schoolbasedhealthcenter" : {
                    "default" : "",
                    "description" : "Used to identify this patient as school-based health center patient. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "sex" : {
                    "default" : "",
                    "description" : "Patient's sex (M/F)",
                    "enum" : [
                       "",
                       "F",
                       "M"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Female",
                       "Male"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "ssn" : {
                    "default" : "",
                    "description" : "",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "state" : {
                    "default" : "",
                    "description" : "Patient's state (2 letter abbreviation)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "status" : {
                    "default" : "",
                    "description" : "The \"status\" of the patient, one of active, inactive, prospective, or deleted.",
                    "enum" : [
                       "",
                       "a",
                       "d",
                       "i",
                       "p"
                    ],
                    "enumDescriptions" : [
                       "",
                       "active",
                       "deleted",
                       "inactive",
                       "prospective"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "suffix" : {
                    "default" : "",
                    "description" : "Patient's name suffix (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "upcomingappointmenthours" : {
                    "default" : "",
                    "description" : "Used to identify patients with appointments scheduled within the upcoming input hours (maximum 24).  Also includes results from the previous 2 hours.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "veteran" : {
                    "default" : "",
                    "description" : "Used to identify this patient as a veteran. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "workphone" : {
                    "default" : "",
                    "description" : "The patient's work phone number.  Generally not used to contact a patient.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "zip" : {
                    "default" : "",
                    "description" : "Patient's zip.  Matching occurs on first 5 characters.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients"
           },
           "POST /patients" : {
              "description" : "Create a patient",
              "httpMethod" : "POST",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "address1" : {
                    "default" : "",
                    "description" : "Patient's address - 1st line (Max length: 100)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "address2" : {
                    "default" : "",
                    "description" : "Patient's address - 2nd line (Max length: 100)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "agriculturalworker" : {
                    "default" : "",
                    "description" : "Used to identify this patient as an agricultural worker. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "agriculturalworkertype" : {
                    "default" : "",
                    "description" : "For patients that are agricultural workers, identifies the type of worker. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "MIGRANT",
                       "SEASONAL",
                       "UNSPECIFIED"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "Migrant",
                       "Seasonal",
                       "Unspecified"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "caresummarydeliverypreference" : {
                    "default" : "",
                    "description" : "The patient's preference for care summary delivery.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "city" : {
                    "default" : "",
                    "description" : "Patient's city (Max length: 30)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "clinicalordertypegroupid" : {
                    "default" : "",
                    "description" : "The clinical order type group of the clinical provider (Prescription: 10, Lab: 11, Vaccinations: 16).",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "consenttocall" : {
                    "default" : "",
                    "description" : "The flag is used to record the consent of a patient to receive automated calls and text messages per FCC requirements. The requested legal language is 'Entry of any telephone contact number constitutes written consent to receive any automated, prerecorded, and artificial voice telephone calls initiated by the Practice. To alter or revoke this consent, visit the Patient Portal \"Contact Preferences\" page.'",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contacthomephone" : {
                    "default" : "",
                    "description" : "Emergency contact home phone.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactmobilephone" : {
                    "default" : "",
                    "description" : "Emergency contact mobile phone.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactname" : {
                    "default" : "",
                    "description" : "The name of the (emergency) person to contact about the patient. The contactname, contactrelationship, contacthomephone, and contactmobilephone fields are all related to the emergency contact for the patient. They are NOT related to the contractpreference_* fields. (Max length: 20)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference" : {
                    "default" : "",
                    "description" : "The MU-required field for \"preferred contact method\". This is not used by any automated systems.",
                    "enum" : [
                       "",
                       "HOMEPHONE",
                       "MAIL",
                       "MOBILEPHONE",
                       "PORTAL",
                       "WORKPHONE"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Home Phone",
                       "Mail",
                       "Mobile Phone",
                       "Portal",
                       "Work Phone"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_announcement_email" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"announcement\" communications delivered via email.  Note that this will not be present if the practice or patient has not set it.For completeness, turning email off is supported via the API, but it is discouraged. When email is off, patients may not not get messages from the patient portal.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_announcement_phone" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"announcement\" communications delivered via phone.  Note that this will not be present if the practice or patient has not set it.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_announcement_sms" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"announcement\" communications delivered via SMS.  Note that this will not be present if the practice or patient has not set it.For SMS, there is specific terms of service language that must be used when displaying this as an option to be turned on.  Turning on must be an action by the patient, not a practice user.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_appointment_email" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"appointment\" communications delivered via email.  Note that this will not be present if the practice or patient has not set it.For completeness, turning email off is supported via the API, but it is discouraged. When email is off, patients may not not get messages from the patient portal.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_appointment_phone" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"appointment\" communications delivered via phone.  Note that this will not be present if the practice or patient has not set it.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_appointment_sms" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"appointment\" communications delivered via SMS.  Note that this will not be present if the practice or patient has not set it.For SMS, there is specific terms of service language that must be used when displaying this as an option to be turned on.  Turning on must be an action by the patient, not a practice user.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_billing_email" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"billing\" communications delivered via email.  Note that this will not be present if the practice or patient has not set it.For completeness, turning email off is supported via the API, but it is discouraged. When email is off, patients may not not get messages from the patient portal.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_billing_phone" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"billing\" communications delivered via phone.  Note that this will not be present if the practice or patient has not set it.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_billing_sms" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"billing\" communications delivered via SMS.  Note that this will not be present if the practice or patient has not set it.For SMS, there is specific terms of service language that must be used when displaying this as an option to be turned on.  Turning on must be an action by the patient, not a practice user.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_lab_email" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"lab\" communications delivered via email.  Note that this will not be present if the practice or patient has not set it.For completeness, turning email off is supported via the API, but it is discouraged. When email is off, patients may not not get messages from the patient portal.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_lab_phone" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"lab\" communications delivered via phone.  Note that this will not be present if the practice or patient has not set it.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_lab_sms" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"lab\" communications delivered via SMS.  Note that this will not be present if the practice or patient has not set it.For SMS, there is specific terms of service language that must be used when displaying this as an option to be turned on.  Turning on must be an action by the patient, not a practice user.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactrelationship" : {
                    "default" : "",
                    "description" : "Emergency contact relationship (one of SPOUSE, PARENT, CHILD, SIBLING, FRIEND, COUSIN, GUARDIAN, OTHER)",
                    "enum" : [
                       "",
                       "CHILD",
                       "COUSIN",
                       "FRIEND",
                       "GUARDIAN",
                       "OTHER",
                       "PARENT",
                       "SIBLING",
                       "SPOUSE"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Child",
                       "Cousin",
                       "Friend",
                       "Guardian",
                       "Other",
                       "Parent",
                       "Sibling",
                       "Spouse"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "countrycode3166" : {
                    "default" : "US",
                    "description" : "Patient's country code (ISO 3166-1) (Max length: 20)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "deceaseddate" : {
                    "default" : "",
                    "description" : "If present, the date on which a patient died.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "defaultpharmacyncpdpid" : {
                    "default" : "",
                    "description" : "The NCPDP ID of the patient's preferred pharmacy.  See http://www.ncpdp.org/ for details. Note: if updating this field, please make sure to have a CLINICALORDERYPEGROUPID field as well.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "Primary (registration) department ID.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "dob" : {
                    "default" : "",
                    "description" : "Patient's DOB (mm/dd/yyyy)",
                    "format" : "date",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "email" : {
                    "default" : "",
                    "description" : "Patient's email address.  'declined' can be used to indicate just that.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "employerid" : {
                    "default" : "",
                    "description" : "The patient's employer's ID (from /employers call)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "employerphone" : {
                    "default" : "",
                    "description" : "The patient's employer's phone number. Normally, this is set by setting employerid. However, setting this value can be used to override this on an individual patient.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "ethnicitycode" : {
                    "default" : "",
                    "description" : "Ethnicity of the patient, using the 2.16.840.1.113883.5.50 codeset. See http://www.hl7.org/implement/standards/fhir/terminologies-v3.html Special case: use \"declined\" to indicate that the patient declined to answer.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "firstname" : {
                    "default" : "",
                    "description" : "Patient's first name (Max length: 20)",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "guarantoraddress1" : {
                    "default" : "",
                    "description" : "Guarantor's address (Max length: 100)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantoraddress2" : {
                    "default" : "",
                    "description" : "Guarantor's address - line 2 (Max length: 100)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorcity" : {
                    "default" : "",
                    "description" : "Guarantor's city (Max length: 30)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorcountrycode3166" : {
                    "default" : "US",
                    "description" : "Guarantor's country code (ISO 3166-1) (Max length: 20)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantordob" : {
                    "default" : "",
                    "description" : "Guarantor's DOB (mm/dd/yyyy)",
                    "format" : "date",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantoremail" : {
                    "default" : "",
                    "description" : "Guarantor's email address",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantoremployerid" : {
                    "default" : "",
                    "description" : "The guaranror's employer's ID (from /employers call)",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "guarantorfirstname" : {
                    "default" : "",
                    "description" : "Guarantor's first name (Max length: 20)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorlastname" : {
                    "default" : "",
                    "description" : "Guarantor's last name (Max length: 20)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantormiddlename" : {
                    "default" : "",
                    "description" : "Guarantor's middle name (Max length: 20)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorphone" : {
                    "default" : "",
                    "description" : "Guarantor's phone number.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorrelationshiptopatient" : {
                    "default" : "1",
                    "description" : "The guarantor's relationship to the patient",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorssn" : {
                    "default" : "",
                    "description" : "Guarantor's SSN",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorstate" : {
                    "default" : "",
                    "description" : "Guarantor's state (2 letter abbreviation)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorsuffix" : {
                    "default" : "",
                    "description" : "Guarantor's name suffix (Max length: 20)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorzip" : {
                    "default" : "",
                    "description" : "Guarantor's zip",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guardianfirstname" : {
                    "default" : "",
                    "description" : "The first name of the patient's guardian.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guardianlastname" : {
                    "default" : "",
                    "description" : "The last name of the patient's guardian.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guardianmiddlename" : {
                    "default" : "",
                    "description" : "The middle name of the patient's guardian.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "guardiansuffix" : {
                    "default" : "",
                    "description" : "The suffix of the patient's guardian.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "hasmobileyn" : {
                    "default" : "",
                    "description" : "Set to false if a client has declined a phone number.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "homeboundyn" : {
                    "default" : "",
                    "description" : "If the patient is homebound, this is true.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "homeless" : {
                    "default" : "",
                    "description" : "Used to identify this patient as homeless. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "homelesstype" : {
                    "default" : "",
                    "description" : "For patients that are homeless, provides more detail regarding the patient's homeless situation. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "DOUBLINGUP",
                       "SHELTER",
                       "OTHER",
                       "STREET",
                       "TRANSITIONAL",
                       "UNSPECIFIED"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "Doubling Up",
                       "Homeless Shelter",
                       "Other",
                       "Street",
                       "Transitional",
                       "Unspecified"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "homephone" : {
                    "default" : "",
                    "description" : "The patient's home phone number.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "ignorerestrictions" : {
                    "default" : "",
                    "description" : "Set to true to allow ability to find patients with record restrictions and blocked patients. This should only be used when there is no reflection to the patient at all that a match was found or not found.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "industrycode" : {
                    "default" : "",
                    "description" : "Industry of the patient, using the US Census industry code (code system 2.16.840.1.113883.6.310).  \"other\" can be used as well.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "language6392code" : {
                    "default" : "",
                    "description" : "Language of the patient, using the ISO 639.2 code. (http://www.loc.gov/standards/iso639-2/php/code_list.php; \"T\" or terminology code) Special case: use \"declined\" to indicate that the patient declined to answer.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "lastname" : {
                    "default" : "",
                    "description" : "Patient's last name (Max length: 20)",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "maritalstatus" : {
                    "default" : "",
                    "description" : "Marital Status (D=Divorced, M=Married, S=Single, U=Unknown, W=Widowed, X=Separated, P=Partner)",
                    "enum" : [
                       "",
                       "D",
                       "M",
                       "P",
                       "X",
                       "S",
                       "U",
                       "W"
                    ],
                    "enumDescriptions" : [
                       "",
                       "DIVORCED",
                       "MARRIED",
                       "PARTNER",
                       "SEPARATED",
                       "SINGLE",
                       "UNKNOWN",
                       "WIDOWED"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "middlename" : {
                    "default" : "",
                    "description" : "Patient's middle name (Max length: 20)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "mobilecarrierid" : {
                    "default" : "",
                    "description" : "The ID of the mobile carrier, from /mobilecarriers or the list below.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "mobilephone" : {
                    "default" : "",
                    "description" : "The patient's mobile phone number. On input, 'declined' can be used to indicate no number. (Alternatively, hasmobile can also be set to false. \"declined\" simply does this for you.)  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "nextkinname" : {
                    "default" : "",
                    "description" : "The full name of the next of kin.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "nextkinphone" : {
                    "default" : "",
                    "description" : "The next of kin phone number.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "nextkinrelationship" : {
                    "default" : "",
                    "description" : "The next of kin relationship (one of SPOUSE, PARENT, CHILD, SIBLING, FRIEND, COUSIN, GUARDIAN, OTHER)",
                    "enum" : [
                       "",
                       "CHILD",
                       "COUSIN",
                       "FRIEND",
                       "GUARDIAN",
                       "OTHER",
                       "PARENT",
                       "SIBLING",
                       "SPOUSE"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Child",
                       "Cousin",
                       "Friend",
                       "Guardian",
                       "Other",
                       "Parent",
                       "Sibling",
                       "Spouse"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "notes" : {
                    "default" : "",
                    "description" : "Notes associated with this patient.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "occupationcode" : {
                    "default" : "",
                    "description" : "Occupation of the patient, using the US Census occupation code (code system 2.16.840.1.113883.6.240).  \"other\" can be used as well.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "onlinestatementonlyyn" : {
                    "default" : "",
                    "description" : "Set to true if a patient wishes to get e-statements instead of paper statements. Should only be set for patients with an email address and clients with athenaCommunicator. The language we use in the portal is, \"Future billing statements will be sent to you securely via your Patient Portal account. You will receive an email notice when new statements are available.\" This language is not required, but it is given as a suggestion.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "portalaccessgiven" : {
                    "default" : "",
                    "description" : "This flag is set if the patient has been given access to the portal. This may be set by the API user if a patient has been given access to the portal \"by providing a preprinted brochure or flyer showing the URL where patients can access their Patient Care Summaries.\" The practiceinfo endpoint can provide the portal URL. While technically allowed, it would be very unusual to set this to false via the API.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "povertylevelfamilysize" : {
                    "default" : "",
                    "description" : "Patient's family size (used for determining poverty level). Only settable if client has Federal Poverty Level fields turned on.",
                    "location" : "body",
                    "required" : false,
                    "type" : "number"
                 },
                 "povertylevelincomepayperiod" : {
                    "default" : "",
                    "description" : "Patient's pay period (used for determining poverty level). Only settable if client has Federal Poverty Level fields turned on.",
                    "enum" : [
                       "",
                       "BIWEEK",
                       "MONTH",
                       "WEEK",
                       "YEAR"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "2 Weeks",
                       "Month",
                       "Week",
                       "Year"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "povertylevelincomeperpayperiod" : {
                    "default" : "",
                    "description" : "Patient's income per specified pay period (used for determining poverty level). Only settable if client has Federal Poverty Level fields turned on.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "preferredname" : {
                    "default" : "",
                    "description" : "The patient's preferred name (i.e. nickname).",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "primarydepartmentid" : {
                    "default" : "",
                    "description" : "The patient's \"current\" department. This field is not always set by the practice.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "primaryproviderid" : {
                    "default" : "",
                    "description" : "The \"primary\" provider for this patient, if set.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "publichousing" : {
                    "default" : "",
                    "description" : "Used to identify this patient as living in public housing. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "race" : {
                    "default" : "",
                    "description" : "The patient race, using the 2.16.840.1.113883.5.104 codeset.  See http://www.hl7.org/implement/standards/fhir/terminologies-v3.html Special case: use \"declined\" to indicate that the patient declined to answer. Multiple values or a tab-seperated list of codes is acceptable for multiple races for input.  The first race will be considered \"primary\".  Note: you must update all values at once if you update any.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "referralsourceid" : {
                    "default" : "",
                    "description" : "The referral / \"how did you hear about us\" ID.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "schoolbasedhealthcenter" : {
                    "default" : "",
                    "description" : "Used to identify this patient as school-based health center patient. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "sex" : {
                    "default" : "",
                    "description" : "Patient's sex (M/F)",
                    "enum" : [
                       "",
                       "F",
                       "M"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Female",
                       "Male"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "ssn" : {
                    "default" : "",
                    "description" : "",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "state" : {
                    "default" : "",
                    "description" : "Patient's state (2 letter abbreviation)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "status" : {
                    "default" : "a",
                    "description" : "The \"status\" of the patient, one of active, inactive, prospective, or deleted.",
                    "enum" : [
                       "",
                       "a",
                       "d",
                       "i",
                       "p"
                    ],
                    "enumDescriptions" : [
                       "",
                       "active",
                       "deleted",
                       "inactive",
                       "prospective"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "suffix" : {
                    "default" : "",
                    "description" : "Patient's name suffix (Max length: 20)",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "veteran" : {
                    "default" : "",
                    "description" : "Used to identify this patient as a veteran. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "workphone" : {
                    "default" : "",
                    "description" : "The patient's work phone number.  Generally not used to contact a patient.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "zip" : {
                    "default" : "",
                    "description" : "Patient's zip.  Matching occurs on first 5 characters.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients"
           },
           "GET /patients/bestmatch" : {
              "description" : "Find the best match for a patient.  In addition to the specified required fields [dob] and [lastname], one of [ssn, zip, anyphone, homephone, mobilephone, workphone, email] is required, and one of [firstname, preferredname, anyfirstname] is required.  Upcoming appointment information may also be provided to further restrict the match.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "anyfirstname" : {
                    "default" : "",
                    "description" : "Matches either firstname OR preferredname. (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "anyphone" : {
                    "default" : "",
                    "description" : "Any phone number for the patient",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "appointmentdepartmentid" : {
                    "default" : "",
                    "description" : "The ID of the department associated with the upcoming appointment.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "appointmentproviderid" : {
                    "default" : "",
                    "description" : "The ID of the provider associated with the upcoming appointment.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "dob" : {
                    "default" : "",
                    "description" : "Patient's DOB (mm/dd/yyyy)",
                    "format" : "date",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "email" : {
                    "default" : "",
                    "description" : "Patient's email address",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "firstname" : {
                    "default" : "",
                    "description" : "Patient's first name.  Required unless preferredname or anyfirstname is used. (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantoremail" : {
                    "default" : "",
                    "description" : "Guarantor's email address",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorphone" : {
                    "default" : "",
                    "description" : "Guarantor's phone number",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "homephone" : {
                    "default" : "",
                    "description" : "The patient's home phone number",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "ignorerestrictions" : {
                    "default" : "",
                    "description" : "Set to true to allow ability to find patients with record restrictions and blocked patients. This should only be used when there is no reflection to the patient at all that a match was found or not found.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "lastname" : {
                    "default" : "",
                    "description" : "Patient's last name (Max length: 20)",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 },
                 "middlename" : {
                    "default" : "",
                    "description" : "Patient's middle name (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "mobilephone" : {
                    "default" : "",
                    "description" : "The patient's mobile phone number",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "preferredname" : {
                    "default" : "",
                    "description" : "Patient's preferred name (or nickname). (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showportalstatus" : {
                    "default" : "",
                    "description" : "If set, will include portal enrollment status in response.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "N",
                       "Y"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "ssn" : {
                    "default" : "",
                    "description" : "",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "suffix" : {
                    "default" : "",
                    "description" : "Patient's name suffix (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "upcomingappointmenthours" : {
                    "default" : "",
                    "description" : "Used to identify patients with appointments scheduled within the upcoming input hours (maximum 24).  Also includes results from the previous 2 hours.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "workphone" : {
                    "default" : "",
                    "description" : "The patient's work phone number.  Generally not used to contact a patient.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "zip" : {
                    "default" : "",
                    "description" : "Patient's zip (Max length: 20)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/bestmatch"
           },
           "GET /patients/changed" : {
              "description" : "This API call must be set up in advance by using /patients/changed/subscription.  It is used to get a set of changes to patients (generally add, update, delete/merge), often as a replacement to HL7 ADT messages. The output structure is the same as /patients. Note that once retrieved, messages are removed from the list. Thus, it is rare that you want to use an offset parameter.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "ignorerestrictions" : {
                    "default" : "",
                    "description" : "Patient information\tfor patients with record restrictions and blocked patients will not be shown.  Setting this flag to true will show that information for those patients.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "leaveunprocessed" : {
                    "default" : "",
                    "description" : "For testing purposes, do not mark records as processed.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1000, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showprocessedenddatetime" : {
                    "default" : "",
                    "description" : "See showprocessestartdatetime.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showprocessedstartdatetime" : {
                    "default" : "",
                    "description" : "Show already processed changes, starting at this mm/dd/yyyy hh24:mi:ss (Eastern) time. Can be used to refetch data if there was an error such as a timeout and records are marked as already retrieved. This is intended to be used with showprocessedenddatetime and for a short period of time only.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/changed"
           },
           "GET /patients/changed/subscription" : {
              "description" : "Get (GET), set (POST), and remove (DELETE) subscriptions for changed patients for a given practice. Note that updates take up to 5 minutes (in production, sometimes longer in preview) to take effect and be reflected in a GET. For more information, go to [Changed Data Subscriptions](https://developer.athenahealth.com/docs/read/reference/Changed_Appointments_and_Subscriptions).",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/changed/subscription"
           },
           "POST /patients/changed/subscription" : {
              "description" : "Get (GET), set (POST), and remove (DELETE) subscriptions for changed patients for a given practice. Note that updates take up to 5 minutes (in production, sometimes longer in preview) to take effect and be reflected in a GET. For more information, go to [Changed Data Subscriptions](https://developer.athenahealth.com/docs/read/reference/Changed_Appointments_and_Subscriptions).",
              "httpMethod" : "POST",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/changed/subscription"
           },
           "DELETE /patients/changed/subscription" : {
              "description" : "Get (GET), set (POST), and remove (DELETE) subscriptions for changed patients for a given practice. Note that updates take up to 5 minutes (in production, sometimes longer in preview) to take effect and be reflected in a GET. For more information, go to [Changed Data Subscriptions](https://developer.athenahealth.com/docs/read/reference/Changed_Appointments_and_Subscriptions).",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/changed/subscription"
           },
           "GET /patients/clientforms" : {
              "description" : "Get list of client forms avaialable",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department id",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "hidepdfs" : {
                    "default" : "",
                    "description" : "Hides PDF forms if set",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 100, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/patients/clientforms"
           },
           "GET /patients/customfields/{customfieldid}/{customfieldvalue}" : {
              "description" : "For searchable custom fields, retrieve matching patients based on custom field value.  The customfieldvalue is either an actual value for non-select fields or an optionid when the value was from select fields.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":customfieldid" : {
                    "default" : null,
                    "description" : "customfieldid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":customfieldvalue" : {
                    "default" : null,
                    "description" : "customfieldvalue",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "string"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 10, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/patients/customfields/:customfieldid/:customfieldvalue"
           },
           "GET /patients/search" : {
              "description" : "Search for patients in a context, optionally with user permissions.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "athenanetuser" : {
                    "default" : "",
                    "description" : "Username to check permissions against, required for restricted patients",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "maxresults" : {
                    "default" : "",
                    "description" : "Maximum number of results to return (default 50)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "searchterm" : {
                    "default" : "",
                    "description" : "The search term for finding patients, partial name or full patient id",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/search"
           },
           "GET /patients/{patientid}" : {
              "description" : "Get one patient's information",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "ignorerestrictions" : {
                    "default" : "",
                    "description" : "Set to true to allow ability to find patients with record restrictions and blocked patients. This should only be used when there is no reflection to the patient at all that a match was found or not found.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showallclaims" : {
                    "default" : "",
                    "description" : "Include information on claims where there is no outstanding patient balance. (Only to be used when showbalancedetails is selected.)",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showbalancedetails" : {
                    "default" : "",
                    "description" : "Show detailed information on patient balances.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showcustomfields" : {
                    "default" : "",
                    "description" : "Include custom fields for the patient.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showinsurance" : {
                    "default" : "",
                    "description" : "Include patient insurance information.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showportalstatus" : {
                    "default" : "",
                    "description" : "If set, will include portal enrollment status in response.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid"
           },
           "PUT /patients/{patientid}" : {
              "description" : "Update a patient",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "address1" : {
                    "default" : "",
                    "description" : "Patient's address - 1st line (Max length: 100)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "address2" : {
                    "default" : "",
                    "description" : "Patient's address - 2nd line (Max length: 100)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "agriculturalworker" : {
                    "default" : "",
                    "description" : "Used to identify this patient as an agricultural worker. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "agriculturalworkertype" : {
                    "default" : "",
                    "description" : "For patients that are agricultural workers, identifies the type of worker. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "MIGRANT",
                       "SEASONAL",
                       "UNSPECIFIED"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "Migrant",
                       "Seasonal",
                       "Unspecified"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "caresummarydeliverypreference" : {
                    "default" : "",
                    "description" : "The patient's preference for care summary delivery.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "city" : {
                    "default" : "",
                    "description" : "Patient's city (Max length: 30)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "clinicalordertypegroupid" : {
                    "default" : "",
                    "description" : "The clinical order type group of the clinical provider (Prescription: 10, Lab: 11, Vaccinations: 16).",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "consenttocall" : {
                    "default" : "",
                    "description" : "The flag is used to record the consent of a patient to receive automated calls and text messages per FCC requirements. The requested legal language is 'Entry of any telephone contact number constitutes written consent to receive any automated, prerecorded, and artificial voice telephone calls initiated by the Practice. To alter or revoke this consent, visit the Patient Portal \"Contact Preferences\" page.'",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contacthomephone" : {
                    "default" : "",
                    "description" : "Emergency contact home phone.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactmobilephone" : {
                    "default" : "",
                    "description" : "Emergency contact mobile phone.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactname" : {
                    "default" : "",
                    "description" : "The name of the (emergency) person to contact about the patient. The contactname, contactrelationship, contacthomephone, and contactmobilephone fields are all related to the emergency contact for the patient. They are NOT related to the contractpreference_* fields.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference" : {
                    "default" : "",
                    "description" : "The MU-required field for \"preferred contact method\". This is not used by any automated systems.",
                    "enum" : [
                       "",
                       "HOMEPHONE",
                       "MAIL",
                       "MOBILEPHONE",
                       "PORTAL",
                       "WORKPHONE"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Home Phone",
                       "Mail",
                       "Mobile Phone",
                       "Portal",
                       "Work Phone"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_announcement_email" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"announcement\" communications delivered via email.  Note that this will not be present if the practice or patient has not set it.For completeness, turning email off is supported via the API, but it is discouraged. When email is off, patients may not not get messages from the patient portal.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_announcement_phone" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"announcement\" communications delivered via phone.  Note that this will not be present if the practice or patient has not set it.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_announcement_sms" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"announcement\" communications delivered via SMS.  Note that this will not be present if the practice or patient has not set it.For SMS, there is specific terms of service language that must be used when displaying this as an option to be turned on.  Turning on must be an action by the patient, not a practice user.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_appointment_email" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"appointment\" communications delivered via email.  Note that this will not be present if the practice or patient has not set it.For completeness, turning email off is supported via the API, but it is discouraged. When email is off, patients may not not get messages from the patient portal.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_appointment_phone" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"appointment\" communications delivered via phone.  Note that this will not be present if the practice or patient has not set it.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_appointment_sms" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"appointment\" communications delivered via SMS.  Note that this will not be present if the practice or patient has not set it.For SMS, there is specific terms of service language that must be used when displaying this as an option to be turned on.  Turning on must be an action by the patient, not a practice user.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_billing_email" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"billing\" communications delivered via email.  Note that this will not be present if the practice or patient has not set it.For completeness, turning email off is supported via the API, but it is discouraged. When email is off, patients may not not get messages from the patient portal.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_billing_phone" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"billing\" communications delivered via phone.  Note that this will not be present if the practice or patient has not set it.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_billing_sms" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"billing\" communications delivered via SMS.  Note that this will not be present if the practice or patient has not set it.For SMS, there is specific terms of service language that must be used when displaying this as an option to be turned on.  Turning on must be an action by the patient, not a practice user.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_lab_email" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"lab\" communications delivered via email.  Note that this will not be present if the practice or patient has not set it.For completeness, turning email off is supported via the API, but it is discouraged. When email is off, patients may not not get messages from the patient portal.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_lab_phone" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"lab\" communications delivered via phone.  Note that this will not be present if the practice or patient has not set it.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactpreference_lab_sms" : {
                    "default" : "",
                    "description" : "If set, the patient has indicated a preference to get or not get \"lab\" communications delivered via SMS.  Note that this will not be present if the practice or patient has not set it.For SMS, there is specific terms of service language that must be used when displaying this as an option to be turned on.  Turning on must be an action by the patient, not a practice user.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "contactrelationship" : {
                    "default" : "",
                    "description" : "Emergency contact relationship (one of SPOUSE, PARENT, CHILD, SIBLING, FRIEND, COUSIN, GUARDIAN, OTHER)",
                    "enum" : [
                       "",
                       "CHILD",
                       "COUSIN",
                       "FRIEND",
                       "GUARDIAN",
                       "OTHER",
                       "PARENT",
                       "SIBLING",
                       "SPOUSE"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Child",
                       "Cousin",
                       "Friend",
                       "Guardian",
                       "Other",
                       "Parent",
                       "Sibling",
                       "Spouse"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "countrycode3166" : {
                    "default" : "US",
                    "description" : "Patient's country code (ISO 3166-1)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "deceaseddate" : {
                    "default" : "",
                    "description" : "If present, the date on which a patient died.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "defaultpharmacyncpdpid" : {
                    "default" : "",
                    "description" : "The NCPDP ID of the patient's preferred pharmacy.  See http://www.ncpdp.org/ for details. Note: if updating this field, please make sure to have a CLINICALORDERYPEGROUPID field as well.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "Primary (registration) department ID.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "dob" : {
                    "default" : "",
                    "description" : "Patient's DOB (mm/dd/yyyy)",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "email" : {
                    "default" : "",
                    "description" : "Patient's email address.  'declined' can be used to indicate just that.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "employerid" : {
                    "default" : "",
                    "description" : "The patient's employer's ID (from /employers call)",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "employerphone" : {
                    "default" : "",
                    "description" : "The patient's employer's phone number. Normally, this is set by setting employerid. However, setting this value can be used to override this on an individual patient.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "ethnicitycode" : {
                    "default" : "",
                    "description" : "Ethnicity of the patient, using the 2.16.840.1.113883.5.50 codeset. See http://www.hl7.org/implement/standards/fhir/terminologies-v3.html Special case: use \"declined\" to indicate that the patient declined to answer.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "firstname" : {
                    "default" : "",
                    "description" : "Patient's first name",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantoraddress1" : {
                    "default" : "",
                    "description" : "Guarantor's address (Max length: 100)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantoraddress2" : {
                    "default" : "",
                    "description" : "Guarantor's address - line 2 (Max length: 100)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorcity" : {
                    "default" : "",
                    "description" : "Guarantor's city (Max length: 30)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorcountrycode3166" : {
                    "default" : "US",
                    "description" : "Guarantor's country code (ISO 3166-1)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantordob" : {
                    "default" : "",
                    "description" : "Guarantor's DOB (mm/dd/yyyy)",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantoremail" : {
                    "default" : "",
                    "description" : "Guarantor's email address",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantoremployerid" : {
                    "default" : "",
                    "description" : "The guaranror's employer's ID (from /employers call)",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "guarantorfirstname" : {
                    "default" : "",
                    "description" : "Guarantor's first name",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorlastname" : {
                    "default" : "",
                    "description" : "Guarantor's last name",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantormiddlename" : {
                    "default" : "",
                    "description" : "Guarantor's middle name",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorphone" : {
                    "default" : "",
                    "description" : "Guarantor's phone number.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorrelationshiptopatient" : {
                    "default" : "1",
                    "description" : "The guarantor's relationship to the patient",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorssn" : {
                    "default" : "",
                    "description" : "Guarantor's SSN",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorstate" : {
                    "default" : "",
                    "description" : "Guarantor's state (2 letter abbreviation)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorsuffix" : {
                    "default" : "",
                    "description" : "Guarantor's name suffix",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guarantorzip" : {
                    "default" : "",
                    "description" : "Guarantor's zip",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guardianfirstname" : {
                    "default" : "",
                    "description" : "The first name of the patient's guardian.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guardianlastname" : {
                    "default" : "",
                    "description" : "The last name of the patient's guardian.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guardianmiddlename" : {
                    "default" : "",
                    "description" : "The middle name of the patient's guardian.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "guardiansuffix" : {
                    "default" : "",
                    "description" : "The suffix of the patient's guardian.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "hasmobileyn" : {
                    "default" : "",
                    "description" : "Set to false if a client has declined a phone number.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "homeboundyn" : {
                    "default" : "",
                    "description" : "If the patient is homebound, this is true.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "homeless" : {
                    "default" : "",
                    "description" : "Used to identify this patient as homeless. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "homelesstype" : {
                    "default" : "",
                    "description" : "For patients that are homeless, provides more detail regarding the patient's homeless situation. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "DOUBLINGUP",
                       "SHELTER",
                       "OTHER",
                       "STREET",
                       "TRANSITIONAL",
                       "UNSPECIFIED"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "Doubling Up",
                       "Homeless Shelter",
                       "Other",
                       "Street",
                       "Transitional",
                       "Unspecified"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "homephone" : {
                    "default" : "",
                    "description" : "The patient's home phone number.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "ignorerestrictions" : {
                    "default" : "",
                    "description" : "Set to true to allow ability to find patients with record restrictions and blocked patients. This should only be used when there is no reflection to the patient at all that a match was found or not found.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "industrycode" : {
                    "default" : "",
                    "description" : "Industry of the patient, using the US Census industry code (code system 2.16.840.1.113883.6.310).  \"other\" can be used as well.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "language6392code" : {
                    "default" : "",
                    "description" : "Language of the patient, using the ISO 639.2 code. (http://www.loc.gov/standards/iso639-2/php/code_list.php; \"T\" or terminology code) Special case: use \"declined\" to indicate that the patient declined to answer.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "lastname" : {
                    "default" : "",
                    "description" : "Patient's last name",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "maritalstatus" : {
                    "default" : "",
                    "description" : "Marital Status (D=Divorced, M=Married, S=Single, U=Unknown, W=Widowed, X=Separated, P=Partner)",
                    "enum" : [
                       "",
                       "D",
                       "M",
                       "P",
                       "X",
                       "S",
                       "U",
                       "W"
                    ],
                    "enumDescriptions" : [
                       "",
                       "DIVORCED",
                       "MARRIED",
                       "PARTNER",
                       "SEPARATED",
                       "SINGLE",
                       "UNKNOWN",
                       "WIDOWED"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "middlename" : {
                    "default" : "",
                    "description" : "Patient's middle name",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "mobilecarrierid" : {
                    "default" : "",
                    "description" : "The ID of the mobile carrier, from /mobilecarriers or the list below.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "mobilephone" : {
                    "default" : "",
                    "description" : "The patient's mobile phone number. On input, 'declined' can be used to indicate no number. (Alternatively, hasmobile can also be set to false. \"declined\" simply does this for you.)  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "nextkinname" : {
                    "default" : "",
                    "description" : "The full name of the next of kin.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "nextkinphone" : {
                    "default" : "",
                    "description" : "The next of kin phone number.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "nextkinrelationship" : {
                    "default" : "",
                    "description" : "The next of kin relationship (one of SPOUSE, PARENT, CHILD, SIBLING, FRIEND, COUSIN, GUARDIAN, OTHER)",
                    "enum" : [
                       "",
                       "CHILD",
                       "COUSIN",
                       "FRIEND",
                       "GUARDIAN",
                       "OTHER",
                       "PARENT",
                       "SIBLING",
                       "SPOUSE"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Child",
                       "Cousin",
                       "Friend",
                       "Guardian",
                       "Other",
                       "Parent",
                       "Sibling",
                       "Spouse"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "notes" : {
                    "default" : "",
                    "description" : "Notes associated with this patient.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "occupationcode" : {
                    "default" : "",
                    "description" : "Occupation of the patient, using the US Census occupation code (code system 2.16.840.1.113883.6.240).  \"other\" can be used as well.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "onlinestatementonlyyn" : {
                    "default" : "",
                    "description" : "Set to true if a patient wishes to get e-statements instead of paper statements. Should only be set for patients with an email address and clients with athenaCommunicator. The language we use in the portal is, \"Future billing statements will be sent to you securely via your Patient Portal account. You will receive an email notice when new statements are available.\" This language is not required, but it is given as a suggestion.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "patientid" : {
                    "default" : "",
                    "description" : "The athenaNet patient ID",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "portalaccessgiven" : {
                    "default" : "",
                    "description" : "This flag is set if the patient has been given access to the portal. This may be set by the API user if a patient has been given access to the portal \"by providing a preprinted brochure or flyer showing the URL where patients can access their Patient Care Summaries.\" The practiceinfo endpoint can provide the portal URL. While technically allowed, it would be very unusual to set this to false via the API.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "povertylevelfamilysize" : {
                    "default" : "",
                    "description" : "Patient's family size (used for determining poverty level). Only settable if client has Federal Poverty Level fields turned on.",
                    "location" : "query",
                    "required" : false,
                    "type" : "number"
                 },
                 "povertylevelincomepayperiod" : {
                    "default" : "",
                    "description" : "Patient's pay period (used for determining poverty level). Only settable if client has Federal Poverty Level fields turned on.",
                    "enum" : [
                       "",
                       "BIWEEK",
                       "MONTH",
                       "WEEK",
                       "YEAR"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "2 Weeks",
                       "Month",
                       "Week",
                       "Year"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "povertylevelincomeperpayperiod" : {
                    "default" : "",
                    "description" : "Patient's income per specified pay period (used for determining poverty level). Only settable if client has Federal Poverty Level fields turned on.",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "preferredname" : {
                    "default" : "",
                    "description" : "The patient's preferred name (i.e. nickname).",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "primarydepartmentid" : {
                    "default" : "",
                    "description" : "The patient's \"current\" department. This field is not always set by the practice.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "primaryproviderid" : {
                    "default" : "",
                    "description" : "The \"primary\" provider for this patient, if set.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "publichousing" : {
                    "default" : "",
                    "description" : "Used to identify this patient as living in public housing. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "race" : {
                    "default" : "",
                    "description" : "The patient race, using the 2.16.840.1.113883.5.104 codeset.  See http://www.hl7.org/implement/standards/fhir/terminologies-v3.html Special case: use \"declined\" to indicate that the patient declined to answer. Multiple values or a tab-seperated list of codes is acceptable for multiple races for input.  The first race will be considered \"primary\".  Note: you must update all values at once if you update any.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "referralsourceid" : {
                    "default" : "",
                    "description" : "The referral / \"how did you hear about us\" ID.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "schoolbasedhealthcenter" : {
                    "default" : "",
                    "description" : "Used to identify this patient as school-based health center patient. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "sex" : {
                    "default" : "",
                    "description" : "Patient's sex (M/F)",
                    "enum" : [
                       "",
                       "F",
                       "M"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Female",
                       "Male"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showportalstatus" : {
                    "default" : "",
                    "description" : "If set, will include portal enrollment status in response.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "ssn" : {
                    "default" : "",
                    "description" : "",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "state" : {
                    "default" : "",
                    "description" : "Patient's state (2 letter abbreviation)",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "status" : {
                    "default" : "a",
                    "description" : "The \"status\" of the patient, one of active, inactive, prospective, or deleted.",
                    "enum" : [
                       "",
                       "a",
                       "d",
                       "i",
                       "p"
                    ],
                    "enumDescriptions" : [
                       "",
                       "active",
                       "deleted",
                       "inactive",
                       "prospective"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "suffix" : {
                    "default" : "",
                    "description" : "Patient's name suffix",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "veteran" : {
                    "default" : "",
                    "description" : "Used to identify this patient as a veteran. Only settable if client has Social Determinant fields turned on.",
                    "enum" : [
                       "",
                       "N",
                       "P",
                       "Y"
                    ],
                    "enumDescriptions" : [
                       "(null)",
                       "No",
                       "Patient Declined",
                       "Yes"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "workphone" : {
                    "default" : "",
                    "description" : "The patient's work phone number.  Generally not used to contact a patient.  Invalid numbers in a GET/PUT will be ignored.  Patient phone numbers and other data may change, and one phone number may be associated with multiple patients. You are responsible for taking additional steps to verify patient identity and for using this data in accordance with applicable law, including HIPAA.  Invalid numbers in a POST will be ignored, possibly resulting in an error.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "zip" : {
                    "default" : "",
                    "description" : "Patient's zip.  Matching occurs on first 5 characters.",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid"
           },
           "GET /patients/{patientid}/appointments" : {
              "description" : "List a patient's appointments",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 1500, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showcancelled" : {
                    "default" : "",
                    "description" : "Show cancelled appointments",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "N",
                       "Y"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showpast" : {
                    "default" : "",
                    "description" : "Show appointments that were before today",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "N",
                       "Y"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/appointments"
           },
           "GET /patients/{patientid}/appointments/{appointmentid}" : {
              "description" : "Retrieve a single appointment, given an appointment ID",
              "httpMethod" : "GET",
              "parameters" : {
                 ":appointmentid" : {
                    "default" : null,
                    "description" : "appointmentid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "showclaimdetail" : {
                    "default" : "false",
                    "description" : "Include claim information, if available, associated with the appointment.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "showinsurance" : {
                    "default" : "false",
                    "description" : "Include patient insurance information.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/appointments/:appointmentid"
           },
           "GET /patients/{patientid}/authorizations" : {
              "description" : "Retreive the list of release authorizations for a given patient.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "Department ID of the patient",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 100, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 },
                 "showdeleted" : {
                    "default" : "",
                    "description" : "Show deleted authorizations",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "status" : {
                    "default" : "",
                    "description" : "Release authorization status (VALID, EXPIRED, REVOKED)",
                    "enum" : [
                       "",
                       "EXPIRED",
                       "REVOKED",
                       "VALID"
                    ],
                    "enumDescriptions" : [
                       "",
                       "EXPIRED",
                       "REVOKED",
                       "VALID"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/authorizations"
           },
           "POST /patients/{patientid}/authorizations" : {
              "description" : "Add a release authorization to the patient.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "clientformid" : {
                    "default" : "",
                    "description" : "The client form ID that the release authorization is for",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "Department ID of the patient",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "effectivedate" : {
                    "default" : "",
                    "description" : "The starting date that the release authorization takes effect",
                    "format" : "date",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 },
                 "expirationdate" : {
                    "default" : "",
                    "description" : "The last date that the release authorization is valid",
                    "format" : "date",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "note" : {
                    "default" : "",
                    "description" : "Any additional notes for the release authorization",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "revokeddate" : {
                    "default" : "",
                    "description" : "The date the release authorization was revoked",
                    "format" : "date",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "signeddate" : {
                    "default" : "",
                    "description" : "The date the release authorization release is signed",
                    "format" : "date",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/authorizations"
           },
           "GET /patients/{patientid}/authorizations/{releaseauthorizationid}" : {
              "description" : "Retreive the list of release authorizations for a given patient.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":releaseauthorizationid" : {
                    "default" : null,
                    "description" : "releaseauthorizationid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "Department ID of the patient",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "showdeleted" : {
                    "default" : "",
                    "description" : "Show deleted authorizations",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "status" : {
                    "default" : "",
                    "description" : "Release authorization status (VALID, EXPIRED, REVOKED)",
                    "enum" : [
                       "",
                       "EXPIRED",
                       "REVOKED",
                       "VALID"
                    ],
                    "enumDescriptions" : [
                       "",
                       "EXPIRED",
                       "REVOKED",
                       "VALID"
                    ],
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/authorizations/:releaseauthorizationid"
           },
           "PUT /patients/{patientid}/authorizations/{releaseauthorizationid}" : {
              "description" : "Update a release authorization to the patient.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":releaseauthorizationid" : {
                    "default" : null,
                    "description" : "releaseauthorizationid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "clientformid" : {
                    "default" : "",
                    "description" : "The client form ID that the release authorization is for",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 },
                 "effectivedate" : {
                    "default" : "",
                    "description" : "The starting date that the release authorization takes effect",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "expirationdate" : {
                    "default" : "",
                    "description" : "The last date that the release authorization is valid",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "note" : {
                    "default" : "",
                    "description" : "Any additional notes for the release authorization",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "revokeddate" : {
                    "default" : "",
                    "description" : "The date the release authorization was revoked",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 },
                 "signeddate" : {
                    "default" : "",
                    "description" : "The date the release authorization release is signed",
                    "format" : "date",
                    "location" : "query",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/authorizations/:releaseauthorizationid"
           },
           "DELETE /patients/{patientid}/authorizations/{releaseauthorizationid}" : {
              "description" : "Delete a release authorization for a given patient.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":releaseauthorizationid" : {
                    "default" : null,
                    "description" : "releaseauthorizationid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "Department ID of the patient",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/authorizations/:releaseauthorizationid"
           },
           "GET /patients/{patientid}/basicdemographics" : {
              "description" : "Get basic demographic information for a single patient.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/basicdemographics"
           },
           "GET /patients/{patientid}/chartalert" : {
              "description" : "Get/Add/Modify/Delete a [chart alert](https://developer.athenahealth.com/docs/read/workflows/Chart_alerts) to the patient Quickview and Facesheet in athenaNet. athenaClinicals is required.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID; needed because charts, and thus chart notes, may be department-specific",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/chartalert"
           },
           "POST /patients/{patientid}/chartalert" : {
              "description" : "Get/Add/Modify/Delete a [chart alert](https://developer.athenahealth.com/docs/read/workflows/Chart_alerts) to the patient Quickview and Facesheet in athenaNet. athenaClinicals is required.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID; needed because charts, and thus chart notes, may be department-specific",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "notetext" : {
                    "default" : "",
                    "description" : "The note text.  Use PUT to add to any existing text and POST if you want to add new or replace the full note",
                    "location" : "body",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/chartalert"
           },
           "PUT /patients/{patientid}/chartalert" : {
              "description" : "Get/Add/Modify/Delete a [chart alert](https://developer.athenahealth.com/docs/read/workflows/Chart_alerts) to the patient Quickview and Facesheet in athenaNet. athenaClinicals is required.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID; needed because charts, and thus chart notes, may be department-specific",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "notetext" : {
                    "default" : "",
                    "description" : "The note text.  Use PUT to add to any existing text and POST if you want to add new or replace the full note",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/chartalert"
           },
           "DELETE /patients/{patientid}/chartalert" : {
              "description" : "Get/Add/Modify/Delete a [chart alert](https://developer.athenahealth.com/docs/read/workflows/Chart_alerts) to the patient Quickview and Facesheet in athenaNet. athenaClinicals is required.",
              "httpMethod" : "DELETE",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID; needed because charts, and thus chart notes, may be department-specific",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/chartalert"
           },
           "GET /patients/{patientid}/customfields" : {
              "description" : "Get a single patient's custom fields.  See /customfields.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/customfields"
           },
           "PUT /patients/{patientid}/customfields" : {
              "description" : "Accepts updates to custom fields. This can also be used as a POST-replacement if no custom fields have been set. Because custom fields can come in many shapes and sizes, modifying custom fields is done by using a JSON structure in the \"customfields\" field. Refer to the [custom fields](https://developer.athenahealth.com/docs/read/workflows/Custom_Fields) documentation for more information.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "customfields" : {
                    "default" : "",
                    "description" : "A JSON representation of any updates to custom fields. The contents of this should match the custom fields output (either with /patients/{patientid}/customfields or within a /patients/{patientid} call) with, of course, any updates. Validation should happen based on the structure given in the /customfields/ call; this means that the values submitted in a select list should be a proper option ID, that number fields are restricted to numbers, and date fields restricted to dates (mm/dd/yyyy).",
                    "location" : "query",
                    "required" : true,
                    "type" : "textarea"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "",
                    "location" : "query",
                    "required" : true,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/customfields"
           },
           "GET /patients/{patientid}/interfaceconsents" : {
              "description" : "Get a list of interface consents for the given patient.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "Department ID",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 },
                 "limit" : {
                    "default" : "",
                    "description" : "Number of entries to return (default 100, max 5000)",
                    "location" : "query",
                    "required" : false
                 },
                 "offset" : {
                    "default" : "",
                    "description" : "Starting point of entries; 0-indexed",
                    "location" : "query",
                    "required" : false
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/interfaceconsents"
           },
           "PUT /patients/{patientid}/interfaceconsents" : {
              "description" : "Update a release authorization to the patient.",
              "httpMethod" : "PUT",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "consents" : {
                    "default" : "",
                    "description" : "A JSON array of consents to be updated.",
                    "location" : "query",
                    "required" : false,
                    "type" : "textarea"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "Department ID",
                    "location" : "query",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/interfaceconsents"
           },
           "POST /patients/{patientid}/portalinvitation" : {
              "description" : "Send a portal invitation to a patient or third party (e.g. family member) user. Will send a password reset email if the patient is registered.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "email" : {
                    "default" : "",
                    "description" : "If not the patient (whose email should already be recorded), the email of the third party being invited.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "firstname" : {
                    "default" : "",
                    "description" : "The first name of the third party being granted access.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "homephone" : {
                    "default" : "",
                    "description" : "The home number of the third party being granted access. \"declined\" allowed.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "lastname" : {
                    "default" : "",
                    "description" : "The last name of the third party being granted access.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "mobilephone" : {
                    "default" : "",
                    "description" : "The mobile number of the third party being granted access. \"declined\" allowed.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "patientinitiated" : {
                    "default" : "",
                    "description" : "Defaulting to true, is this action taken by the patient (instead of a practice user).",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "permissionlevel" : {
                    "default" : "",
                    "description" : "If the access is for someone other than the patient, additional fields (first/last name, home/mobile phone, email) also become required. If not passed in, patient is assumed.",
                    "enum" : [
                       "",
                       "FULL",
                       "GUARANTOR",
                       "PATIENT"
                    ],
                    "enumDescriptions" : [
                       "",
                       "Full Access",
                       "Guarantor Access",
                       "Patient"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/portalinvitation"
           },
           "GET /patients/{patientid}/portalstatus" : {
              "description" : "Gets the patient portal status for a patient.",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/portalstatus"
           },
           "GET /patients/{patientid}/privacyinformationverified" : {
              "description" : "In athenaNet, a practice has the flexibility to configure their patient registration page to display the Privacy Notice, Release of Billing Information, and Assignment of Benefits consent forms as 1, 2, or 3 confirmation check boxes. This API returns a count of how many consent check boxes, and the associated labels, that a practice has configured in athenaNet. Additional information can be found in the workflow [documentation](https://developer.athenahealth.com/docs/workflows/Privacy_Information_Verification_Check_Boxes).",
              "httpMethod" : "GET",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The department ID.",
                    "location" : "query",
                    "required" : true,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/privacyinformationverified"
           },
           "POST /patients/{patientid}/privacyinformationverified" : {
              "description" : "Please read the Privacy Information Verification [documentation](https://developer.athenahealth.com/docs/workflows/Privacy_Information_Verification_Check_Boxes) before using this API. This API flags the patient privacy information (Privacy Notice, Release of Billing Information, and Assignment of Benefits) as having been verified. If none of the three flags (PRIVACYNOTICE, PATIENTSIGNATURE, and INSUREDSIGNATURE) are set to true, then this call will mark all three by default. The three flags can be used in any combination. Note: This call can only be used to set the checkboxes. There is currently no API to unset them.",
              "httpMethod" : "POST",
              "parameters" : {
                 ":patientid" : {
                    "default" : null,
                    "description" : "patientid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 ":practiceid" : {
                    "default" : 195900,
                    "description" : "practiceid",
                    "location" : "pathReplace",
                    "required" : true,
                    "type" : "int"
                 },
                 "Authorization" : {
                    "default" : "",
                    "description" : "OAuth2 access token",
                    "location" : "header",
                    "required" : true,
                    "type" : "String"
                 },
                 "Content-Type" : {
                    "default" : "application/x-www-url-form-urlencoded",
                    "description" : "Content type of the payload",
                    "location" : "header",
                    "required" : true,
                    "type" : "string"
                 },
                 "departmentid" : {
                    "default" : "",
                    "description" : "The ID of the department where the privacy information was verified.",
                    "location" : "body",
                    "required" : true,
                    "type" : "int"
                 },
                 "expirationdate" : {
                    "default" : "",
                    "description" : "The date this approval expires (for release of billing information and assignment of benefits).",
                    "format" : "date",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "insuredsignature" : {
                    "default" : "",
                    "description" : "If set, this flag sets the Assignment of Benefits privacy checkbox.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "patientsignature" : {
                    "default" : "",
                    "description" : "If set, this flag sets the Release of Billing Information privacy checkbox.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "privacynotice" : {
                    "default" : "",
                    "description" : "If set, this flag sets the Privacy Notice privacy checkbox.",
                    "enum" : [
                       "",
                       "false",
                       "true"
                    ],
                    "enumDescriptions" : [
                       "",
                       "false",
                       "true"
                    ],
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "reasonpatientunabletosign" : {
                    "default" : "",
                    "description" : "If the patient is unable to sign a reason why.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "signaturedatetime" : {
                    "default" : "",
                    "description" : "If presenting an e-signature, the mm/dd/yyyy hh24:mi:ss formatted time that the signer signed.  This is required if a signature name is provided.",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "signaturename" : {
                    "default" : "",
                    "description" : "If presenting an e-siganture, the name the signer typed, up to 100 characters",
                    "location" : "body",
                    "required" : false,
                    "type" : "string"
                 },
                 "signerrelationshiptopatientid" : {
                    "default" : "",
                    "description" : "If presenting an e-signature, and the signer is signing on behalf of someone else, the relationship of the patient to the signer.  There is a documentation page with details.",
                    "location" : "body",
                    "required" : false,
                    "type" : "int"
                 }
              },
              "path" : "/preview1/:practiceid/patients/:patientid/privacyinformationverified"
           }
        }
     }
   },
   "title" : "Preview API",
   "version" : "/preview1"
}
]]
return AthenaSource;