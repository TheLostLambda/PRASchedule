module PRA.Readers where -- This line allows this file to be later imported using 'import PRA.Readers'. See "Main.hs".
import Data.Csv -- This line imports the Cassava CSV library.
import PRA.Data -- Import datatypes.

-- These imports allow for the handling of data outputted by Cassava.
import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V

-- This function reads CSV into a list of 'Student' values
readCSV :: BL.ByteString -> [Student]
readCSV csv = case decodeByName csv of -- Attempt to decode CSV. If an error occurs respond with 'Left' otherwise respond with 'Right'.
    Left err -> error $ "ERROR WHILE DECODING CSV: " ++ err -- If decoding failed, crash the program and output an error message.
    Right (_, v) -> V.toList $ V.map toStudent v -- Transform the decoded CSV into a list of 'Student' values.
        where toStudent r = Student (name r) (peak r) (teacher r) (choices r) -- Transform a single record into a 'Student'.
