local pool = require "pool"

describe("pool:", function()
	local poolSize = 4
	local objPool

	before_each(function() 
		objPool = pool.create(function() return {} end, poolSize)
	end)

	after_each(function()
		objPool = nil
	end)

	it("Proper pool size on create", function()
		assert.same(#objPool.freeObjects, poolSize)
	end)

	it("Obtain object from pool", function()
		local object = objPool:obtain()
		assert.same(#objPool.freeObjects, poolSize - 1)
		assert.is_not.Nil(object)
	end)

	it("Free object back into pool", function()
		local object = objPool:obtain()
		objPool:free(object)
		assert.same(#objPool.freeObjects, poolSize)
	end)

	it("Clear free objects", function()
		objPool:clear()
		assert.same(#objPool.freeObjects, 0)
	end)
end)

describe("errors:", function()
	it("nil newObject function", function()
		assert.has_error(function() pool.create(nil) end)
	end)

	it("nil free object", function()
		local objPool = pool.create(function() return {} end)
		assert.has_error(function() objPool:free(nil) end)
	end)
end)