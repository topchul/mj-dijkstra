//
//  MJDijkstraNode.h
//  dijkstra
//
//  Created by Gregory J.H. Rho on 13. 6. 20..
//  Copyright (c) 2013년 Dmitri Kozlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJDijkstra.h"

@interface DijkstraNodeTestImpl : NSObject<DijkstraNode>
- (id)initWithUnique:(NSString *)unique;

- (void)addEdge:(id<DijkstraEdge>)edge;
- (void)removeEdge:(id<DijkstraEdge>)edge;

- (BOOL)isEqual:(id)object;
@end
