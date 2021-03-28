# global constants
DATA_DIR <- "data"
ENTITY_TYPE_NAME <- "Names"
ENTITY_TYPE_EXERCISE <- "Exercises"
ENTITY_TYPE_TYPE <- "Types"
ENTITY_TYPE_WEIGHT <- "Weights"
WORKOUT_TRACKER_GOOGLE_SHEET_URL <- "https://docs.google.com/spreadsheets/d/1Bx_xxLHjvOr2gaII8UZiHIxXUCElf5jmbtLazVdE4HQ"
SERVICE_ACCOUNT_JSON_FILE <- "exertracker.json"
EMPTY_DF <- data.frame(date=as.Date(character()), name=character(), type=character(),
                       exercise=character(), weight=double(),
                       sets=double(), reps=double(), notes=character(),
                       stringsAsFactors=FALSE)