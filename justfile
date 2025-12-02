@run task part file="sample.txt":
    cat {{ task / file }} | runhaskell {{ task / "Main" + part + ".hs" }}

@copy task part file="sample.txt":
    just run {{ task }} {{ part }} {{ file }} | wl-copy
