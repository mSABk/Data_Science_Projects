#geting a vector of the files in the directory 
xls_list <- dir(path = "Newyork_property_sales_2012_2022/" ,full.names = TRUE)

setNames(xls_df, basename(xls_list))

xls_df <- map_df(xls_list, read_xls())

list2env(xls_df, envir = .GlobalEnv)

data_frames <- map(xls_list, ~read_excel(.))

----
library(purrr)
file.list <- list.files(pattern='*.csv')
file.list <- setNames(file.list, file.list) # only needed when you need an id-column with the file-names

df <- map_df(file.list, read.csv, .id = "id")
---
  library(readxl)
file.list <- list.files(pattern='*.xlsx')
df.list <- lapply(file.list, read_excel)
---
  library(purrr)
library(readxl)

files_list <- list.files(path = 'Data/raw_data/',
                         pattern = "*.xlsx",
                         full.names = TRUE)
files_list %>% 
  walk2(1:length(files_list),
        ~ assign(paste0("df_", .y), 
                 read_excel(path = .x),
                 envir = globalenv()
        )
  )
--
files_list %>% 
  walk(~ assign(paste0("df_", tools::file_path_sans_ext(basename(.))), 
                read_excel(path = .),
                envir = globalenv()
  )
  )

-----
  library(purrr)
library(readxl)
library(writexl)

# List of Excel file paths
excel_files <- list.files(path = "path/to/excel/files", pattern = "\\.xlsx$", full.names = TRUE)

# Define a function to read Excel and write CSV
read_excel_and_write_csv <- function(excel_file_path) {
  # Read Excel file
  data <- read_excel(excel_file_path)
  
  # Write to CSV file
  csv_file_path <- sub("\\.xlsx$", ".csv", excel_file_path)
  write_xlsx(data, csv_file_path)
}

# Use walk() to apply the function to each Excel file path
walk(excel_files, ~ read_excel_and_write_csv(.))
----
  library(purrr)
library(readxl)
library(writexl)

# List of Excel file paths
excel_files <- list.files(path = "path/to/excel/files", pattern = "\\.xlsx$", full.names = TRUE)

# Define a function to read Excel and write CSV
read_excel_and_write_csv <- function(excel_file_path) {
  # Read Excel file
  data <- read_excel(excel_file_path)
  
  # Get the file name without extension
  file_name <- tools::file_path_sans_ext(basename(excel_file_path))
  
  # Write to CSV file
  csv_file_path <- file.path(dirname(excel_file_path), paste0(file_name, ".csv"))
  write.csv(data, csv_file_path, row.names = FALSE)
}

# Use walk() to apply the function to each Excel file path
walk(excel_files, ~ read_excel_and_write_csv(.))

  
