//
//  DHMyScene.m
//  WaterGameSprit
//
//  Created by binaryboy on 7/6/14.
//  Copyright (c) 2014 AhmedHamdy. All rights reserved.
//

#import "DHMyScene.h"

@implementation DHMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.physicsWorld.gravity = CGVectorMake(+0.0f, -1.8f); // setting the gravity of the scene.
        [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame]];  //Physics body of Scene
        
        self.physicsWorld.contactDelegate =self;
        


//        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//        
//        myLabel.text = @"Hello, World!";
//        myLabel.fontSize = 30;
//        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
//        
//        [self addChild:myLabel];
        SKSpriteNode *ring = [SKSpriteNode spriteNodeWithImageNamed:@"ring"];
        
        ring.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));;
        
        ring.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:ring.size.width/2]; // you can change the radius
        
        ring.physicsBody.dynamic = YES;
        
        
        ring.physicsBody.affectedByGravity=YES;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];

        [ring runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:ring];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *ring = [SKSpriteNode spriteNodeWithImageNamed:@"ring"];
        
        ring.position = location;
        ring.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:ring.size.width/2]; // you can change the radius
        
        ring.physicsBody.dynamic = YES;
        
        
        ring.physicsBody.affectedByGravity=YES;
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [ring runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:ring];
        
        
        
    }
    
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
