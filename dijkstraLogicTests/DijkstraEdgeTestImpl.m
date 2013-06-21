//
//  MJDijkstraEdge.m
//  dijkstra
//
//  Created by Gregory J.H. Rho on 13. 6. 20..
//  Copyright (c) 2013년 Dmitri Kozlov. All rights reserved.
//

#import "DijkstraEdgeTestImpl.h"
#import "DijkstraNodeTestImpl.h"

@implementation DijkstraEdgeTestImpl
@synthesize fromNode = _fromNode;
@synthesize toNode = _toNode;
@synthesize length = _length;

+ (void)setEdgeWithFromNode:(DijkstraNodeTestImpl *)fromNode toNode:(DijkstraNodeTestImpl *)toNode length:(NSNumber *)length
{
    DijkstraEdgeTestImpl *edge = [[DijkstraEdgeTestImpl alloc] init];
    edge->_fromNode = fromNode;
    edge->_toNode = toNode;
    edge->_length = [length copy];
    
    [fromNode addEdge:edge];
}

- (NSString *)description
{
    NSMutableString *s = [@"" mutableCopy];
    [s appendString:[super description]];
    [s appendFormat:@"{fromNode:%@, toNode:%@, length:%@}", self.fromNode.unique, self.toNode.unique, self.length];
    
    return [s copy];
}

@end
