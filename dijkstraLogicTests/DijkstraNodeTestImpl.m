//
//  MJDijkstraNode.m
//  dijkstra
//
//  Created by Gregory J.H. Rho on 13. 6. 20..
//  Copyright (c) 2013년 Dmitri Kozlov. All rights reserved.
//

#import "DijkstraNodeTestImpl.h"

@implementation DijkstraNodeTestImpl {
    NSMutableSet *_edges;
}
@synthesize unique = _unique;
@synthesize edges = _edges;

- (id)init
{
    return [self initWithUnique:nil];
}

- (id)initWithUnique:(NSString *)unique
{
    self = [super init];
    if (self) {
        self->_unique = [unique copy];
        self->_edges = [NSMutableSet set];
    }
    return self;
}


- (id)copyWithZone:(NSZone *)zone
{
    DijkstraNodeTestImpl *newNode = [[DijkstraNodeTestImpl allocWithZone:zone] init];
    newNode->_unique = [self->_unique copyWithZone:zone];
    newNode->_edges = self->_edges;
    
    return newNode;
}

- (NSUInteger)hash
{
    return [self.unique hash] ^ [self.edges hash];
}

- (BOOL)isEqual:(id)object
{
    if (YES != [object isKindOfClass:[DijkstraNodeTestImpl class]]) return NO;
    if (YES != [self.unique isEqualToString:[object unique]]) return NO;
    if (YES != [self.edges isEqualToSet:[object edges]]) return NO;
    
    return YES;
}

- (NSString *)description
{
    NSMutableString *s = [@"" mutableCopy];
    [s appendString:[super description]];
    
    NSMutableArray *edgeDescriptions = [@[] mutableCopy];
    for (id<DijkstraEdge>edge in self.edges) {
        [edgeDescriptions addObject:[NSString stringWithFormat:@"%@:@%@", edge.toNode.unique, edge.length]];
    }
    [edgeDescriptions sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:0];
    }];
    
    if (0 < [edgeDescriptions count]) {
        [s appendFormat:@"{%@, @{%@}}", self.unique, [edgeDescriptions componentsJoinedByString:@", "]];
    } else {
        [s appendFormat:@"{%@, hasNoEdge}", self.unique];
    }

    return [s copy];
}


- (void)addEdge:(id<DijkstraEdge>)edge
{
    [self->_edges addObject:edge];
}
- (void)removeEdge:(id<DijkstraEdge>)edge
{
    [self->_edges removeObject:edge];
}

@end
