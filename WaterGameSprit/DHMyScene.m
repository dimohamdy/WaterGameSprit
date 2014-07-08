//
//  DHMyScene.m
//  WaterGameSprit
//
//  Created by binaryboy on 7/6/14.
//  Copyright (c) 2014 AhmedHamdy. All rights reserved.
//

#import "DHMyScene.h"

@implementation DHMyScene{
    NSMutableArray*rings;
    NSMutableArray*tempRings;

}
static const uint32_t sprite1Category = 0x1 << 0;
static const uint32_t sprite2Category = 0x1 << 1;
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        rings=[[NSMutableArray alloc]init];
        tempRings=[[NSMutableArray alloc]init];
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.physicsWorld.gravity = CGVectorMake(+0.0f, -1.8f); // setting the gravity of the scene.
        [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame]];  //Physics body of Scene
        
        self.physicsWorld.contactDelegate =self;

        self.physicsBody.categoryBitMask = sprite1Category;
        self.physicsBody.contactTestBitMask = sprite2Category;
        for (int count=0; count<7; count++) {
            
            
            [rings addObject:[self setupRing:count]];
            [self addChild:[self setupRing:count]];

        }
        
        [self addChild:[self rightButtonNode]];
        [self addChild:[self leftButtonNode]];
        [self addChild:[self setUpBasket]];



    }
    return self;
}
-(SKSpriteNode*)setupRing:(int)count{
    SKSpriteNode *ring = [SKSpriteNode spriteNodeWithImageNamed:@"ring"];
    
    ring.position = CGPointMake(CGRectGetMidX(self.frame)+count*5, CGRectGetMidY(self.frame)+count*5);;
    
    ring.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:ring.size.width/2]; // you can change the radius
    ring.physicsBody.dynamic = YES;

    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
    [ring runAction:[SKAction repeatActionForever:action] withKey:@"Rotate"];
    ring.physicsBody.affectedByGravity=YES;
    ring.physicsBody.categoryBitMask = sprite2Category;
    ring.physicsBody.contactTestBitMask = sprite1Category;
    ring.physicsBody.mass = 1.0;
    ring.physicsBody.angularDamping = 0.0+count;
    ring.physicsBody.linearDamping = 0.0+count;
    ring.physicsBody.friction = 0.0;
   
    return ring;
}


//Left button
- (SKSpriteNode *)leftButtonNode
{
    SKSpriteNode *fireNode = [SKSpriteNode spriteNodeWithImageNamed:@"push"];
    //fireNode.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:fireNode.size.width/2]; // you can change the radius

    fireNode.position = CGPointMake(15, 30);
    fireNode.name = @"fireButtonNode";//how the node is identified later
    fireNode.zPosition = 1.0;
    return fireNode;
}
//Right button
- (SKSpriteNode *)rightButtonNode
{
    SKSpriteNode *fireNode = [SKSpriteNode spriteNodeWithImageNamed:@"push"];
   // fireNode.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:fireNode.size.width/2]; // you can change the radius

    fireNode.position = CGPointMake(300, 30);
    fireNode.name = @"fireButtonNode";//how the node is identified later
    fireNode.zPosition = 1.0;
    return fireNode;
}
//Basket
- (SKSpriteNode *)setUpBasket
{
    SKSpriteNode *basketNode = [SKSpriteNode spriteNodeWithImageNamed:@"basket"];
    // fireNode.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:fireNode.size.width/2]; // you can change the radius
    
    basketNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    basketNode.name = @"fireButtonNode";//how the node is identified later
    basketNode.zPosition = 1.0;
    return basketNode;
}
////handle touch events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    //if fire button touched, bring the rain
    if ([node.name isEqualToString:@"fireButtonNode"]) {
        //do whatever...
       
        self.physicsWorld.gravity = CGVectorMake(+0.0f, +1.8f); // setting the gravity of the scene.
        [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame]];
        [self performSelector:@selector(resetGravity) withObject:nil afterDelay:1];
    }
}
-(void)resetGravity{
    
    self.physicsWorld.gravity = CGVectorMake(+0.0f, -1.8f); // setting the gravity of the scene.
    [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame]];  //Physics body of Scene

}
- (void)didEndContact:(SKPhysicsContact *)contact{

}
- (void)didBeginContact:(SKPhysicsContact *)contact{
    [contact.bodyB.node removeActionForKey:@"Rotate"];

}

@end
