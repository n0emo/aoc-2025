data Safe = Safe {pos :: Int, zeros :: Int}

initialSafe :: Safe
initialSafe = Safe 50 0

data Rot = Rot {amount :: Int, dir :: Char}

rotate :: Safe -> Rot -> Safe
rotate safe rot = Safe newPos newZeros
  where
    op = case dir rot of
      'R' -> (+)
      'L' -> (-)
    positions = map (\n -> (pos safe `op` n) `rem` 100) [1 .. amount rot]
    zerosCount = length $ filter (== 0) positions
    newPos = last positions
    newZeros = zeros safe + zerosCount

parseLine :: String -> Rot
parseLine line = Rot (read $ tail line) (head line)

main :: IO ()
main = do
  s <- getContents
  let safe = foldl rotate initialSafe (map parseLine $ lines s)
  print $ zeros safe
