-- Teal declarations for windfield (thirdparty/windfield).
-- A Collider forwards unknown methods to its body/fixture/shape and a World
-- to its box2d world; the common ones are declared below, for anything else
-- use collider.body / collider.fixture / world.box2d_world directly.

local record wf
   record CollisionClassSettings
      ignores: {string}
   end

   record ColliderSettings
      collision_class: string
      body_type: string    -- "static" | "dynamic" | "kinematic"
   end

   record Contact
      collider: Collider
      contact: love.physics.Contact
   end

   record Collider
      id: string
      type: string
      collision_class: string
      body: love.physics.Body
      fixture: love.physics.Fixture
      shape: love.physics.Shape
      world: World

      setCollisionClass: function(self, name: string)
      enter: function(self, other_class: string): boolean
      exit: function(self, other_class: string): boolean
      stay: function(self, other_class: string): boolean
      getEnterCollisionData: function(self, other_class: string): Contact
      getExitCollisionData: function(self, other_class: string): Contact
      getStayCollisionData: function(self, other_class: string): {Contact}
      setPreSolve: function(self, callback: function(Collider, Collider, love.physics.Contact))
      setPostSolve: function(self, callback: function(Collider, Collider, love.physics.Contact, number, number, number, number))
      setObject: function(self, object: any)
      getObject: function(self): any
      addShape: function(self, name: string, shape_type: string, ...: number)
      removeShape: function(self, name: string)
      destroy: function(self)

      -- forwarded to body / fixture
      getPosition: function(self): number, number
      setPosition: function(self, x: number, y: number)
      getX: function(self): number
      getY: function(self): number
      getAngle: function(self): number
      setAngle: function(self, angle: number)
      getLinearVelocity: function(self): number, number
      setLinearVelocity: function(self, vx: number, vy: number)
      applyForce: function(self, fx: number, fy: number, x?: number, y?: number)
      applyLinearImpulse: function(self, ix: number, iy: number, x?: number, y?: number)
      setType: function(self, body_type: string)
      setFixedRotation: function(self, fixed: boolean)
      setLinearDamping: function(self, damping: number)
      setGravityScale: function(self, scale: number)
      setMass: function(self, mass: number)
      getMass: function(self): number
      setSensor: function(self, sensor: boolean)
      setRestitution: function(self, restitution: number)
      setFriction: function(self, friction: number)
      setBullet: function(self, bullet: boolean)
      isDestroyed: function(self): boolean
   end

   record World
      box2d_world: love.physics.World

      update: function(self, dt: number)
      draw: function(self, alpha?: number)
      destroy: function(self)
      setQueryDebugDrawing: function(self, value: boolean)
      setExplicitCollisionEvents: function(self, value: boolean)
      addCollisionClass: function(self, name: string, settings?: CollisionClassSettings)
      collisionClassesSet: function(self)

      newCircleCollider: function(self, x: number, y: number, r: number, settings?: ColliderSettings): Collider
      newRectangleCollider: function(self, x: number, y: number, w: number, h: number, settings?: ColliderSettings): Collider
      newBSGRectangleCollider: function(self, x: number, y: number, w: number, h: number, corner_cut: number, settings?: ColliderSettings): Collider
      newPolygonCollider: function(self, vertices: {number}, settings?: ColliderSettings): Collider
      newLineCollider: function(self, x1: number, y1: number, x2: number, y2: number, settings?: ColliderSettings): Collider
      newChainCollider: function(self, vertices: {number}, loop: boolean, settings?: ColliderSettings): Collider

      queryCircleArea: function(self, x: number, y: number, r: number, classes?: {string}): {Collider}
      queryRectangleArea: function(self, x: number, y: number, w: number, h: number, classes?: {string}): {Collider}
      queryPolygonArea: function(self, vertices: {number}, classes?: {string}): {Collider}
      queryLine: function(self, x1: number, y1: number, x2: number, y2: number, classes?: {string}): {Collider}

      addJoint: function(self, joint_type: string, ...: any): love.physics.Joint
      removeJoint: function(self, joint: love.physics.Joint)

      -- forwarded to box2d_world
      setGravity: function(self, gx: number, gy: number)
      getGravity: function(self): number, number
   end

   newWorld: function(xg: number, yg: number, sleep?: boolean): World
end

return wf
