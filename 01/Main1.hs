data Safe = Safe {pos :: Int, zeros :: Int}

initialSafe :: Safe
initialSafe = Safe 50 0

data Rot = Rot {amount :: Int, dir :: Char}

rotate :: Safe -> Rot -> Safe
rotate safe rot = Safe newPos newZeros
  where
    newPos = case dir rot of
      'R' -> (pos safe + amount rot) `rem` 100
      'L' -> (pos safe - amount rot) `rem` 100
    newZeros = if newPos == 0 then zeros safe + 1 else zeros safe

parseLine :: String -> Rot
parseLine line = Rot (read $ tail line) (head line)

main :: IO ()
main = do
  s <- getContents
  let safe = foldl rotate initialSafe (map parseLine $ lines s)
  print $ zeros safe
