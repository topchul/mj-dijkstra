//
//  MJDijkstraEdge.h
//  dijkstra
//
//  Created by Gregory J.H. Rho on 13. 6. 20..
//  Copyright (c) 2013년 Dmitri Kozlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJDijkstra.h"

@interface DijkstraEdgeTestImpl : NSObject<DijkstraEdge>
+ (void)setEdgeWithFromNode:(id<DijkstraNode>)fromNode toNode:(id<DijkstraNode>)toNode length:(NSNumber *)length;
@end
