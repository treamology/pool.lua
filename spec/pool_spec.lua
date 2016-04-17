local pool = require "pool"

describe("pool:", function()
	it("Proper pool size on create", function()
		local objPool = pool.create(function() return {} end, 4)
		assert.same(#objPool.freeObjects, 4)
	end)
end)