module PRA.Data where -- This line allows this file to be later imported using 'import PRA.Data'. See "Main.hs".
import Data.Csv -- This line imports the Cassava CSV library.

-- This file defines all of the datatypes and instances used throughout the rest of the program.

-- This function is sacred, a true master of type-foo.
collapse :: Applicative a => [a x] -> a [x]
collapse = foldr (\c acc -> pure (:) <*> c <*> acc) (pure [])

-- This block defines our 'Student' datatype.
-- This type stores the name, peak, teacher, and top 5 activity choices.
data Student = Student
    { name :: !String
    , peak :: !String
    , teacher :: !String
    , choices :: ![String] -- The brackets here denote a list.
    } deriving (Show, Eq) -- This line tells the compiler to make our 'Student' type part of the 'Show' and 'Eq' typeclasses.

-- This block makes our 'Student' type part of the 'FromNamedRecord' typeclass.
-- This allows Cassava to read CSV and transform the data into a list of 'Student' values.
instance FromNamedRecord Student where
    -- The '<$>' and '<*>' operators help build a value of the 'Student' type, while the '.:' operator tells Cassava
    -- the name of the of column we are looking for in the record ('r').
    parseNamedRecord r = Student <$> (r .: "name") <*> (r .: "peak") <*> (r .: "teacher") <*>
        collapse [r .: "first", r .: "second", r .: "third", r .: "fourth", r .: "fifth"]
