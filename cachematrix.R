## Caching the inverse of a matrix to save time

## Create a special matrix similar to the special vector in the assignment example

makeCacheMatrix <- function(x = matrix()) {
    i <- NULL
    set <- function(y) {
        x <<- y
        i <<- NULL
    }
    
    get <- function() x
    setinverse <- function(inverse) i <<- inverse
    getinverse <- function() i
    list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## Computes the inverse matrix, unless inverse has already been computed and the data is cached

cacheSolve <- function(x, ...) {
    i <- x$getinverse()
    
    if(!is.null(i)) {
        message("Getting cached data.")
        return(i)
    }
    
    dat <- x$get()
    i <- solve(dat, ...)
    x$setinverse(i)
    i
}
