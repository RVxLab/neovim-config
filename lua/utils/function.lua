local M = {}

M.unpack = table.unpack or unpack

---Bind a function with default arguments for later use
---See also [Currying](https://javascript.info/currying-partials)
function M.bind(fn, ...)
    local args = { ... }

    return function()
        return fn(M.unpack(args))
    end
end

---Bind a function with default arguments for later use, calling with pcall
---See also [Currying](https://javascript.info/currying-partials)
function M.pbind(fn, ...)
    local args = { ... }

    return function()
        return pcall(fn, M.unpack(args))
    end
end

---Immediately invoke the function with the given arguments, if any
---
---See [IIFE on MDN](https://developer.mozilla.org/en-US/docs/Glossary/IIFE) for info
function M.invoke(fn, ...)
    return fn(...)
end

---Do nothing
function M.noop()
    -- 🦗
end

return M
