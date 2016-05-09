module Main where -- This line declares the 'Main' module.
import PRA.Data -- Import datatypes.
import PRA.Readers -- Import file readers.

-- This line imports the 'ByteString' library, allowing us to read files into efficient, raw strings.
import qualified Data.ByteString.Lazy as BL

-- This function serves as the entry point of the program.
main = do
    csvData <- BL.readFile "Data/Data.csv" -- Read "Data.csv" into the 'csvData' varible.
    mapM_ print (readCSV csvData) -- Read the CSV into a list of 'Student' values and print them out one-by-one.
