//
//  dijkstraLogicTests.m
//  dijkstraLogicTests
//
//  Created by Dmitri Kozlov on 19/02/13.
//  Copyright (c) 2013 Dmitri Kozlov. All rights reserved.
//

#import "dijkstraLogicTests.h"
#import "MJPriorityQueue.h"
#import "MJPriorityDictionary.h"
#import "MJDijkstra.h"
#import "DijkstraNodeTestImpl.h"
#import "DijkstraEdgeTestImpl.h"

@implementation dijkstraLogicTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

#pragma mark PriorityQueue

- (void)testPriorityQueueEmpty
{
    MJPriorityQueue *q = [MJPriorityQueue queue];
    STAssertTrue([q empty], @"Queue should be empty");
}

- (void)testPriorityQueueSize
{
    MJPriorityQueue *q = [MJPriorityQueue queue];
    [q push:@"string"];
    STAssertTrue([q size] == 1, @"Queue size should be 1");
}

- (void)testPriorityQueuePush
{
    MJPriorityQueue *q = [MJPriorityQueue queue];
    [q push:@"string"];
    STAssertTrue([[q top] isEqual:@"string"], @"Queue top is wrong");
}

- (void)testPriorityQueuePop
{
    MJPriorityQueue *q = [MJPriorityQueue queue];
    [q push:@"string"];
    [q pop];
    STAssertTrue([q size] == 0, @"Queue size should be 0");
}

- (void)testPriorityQueueCleanup
{
    MJPriorityQueue *q = [MJPriorityQueue queue];
    [q push:@"string"];
    [q pop];
    STAssertTrue([q empty], @"Queue should be empty");
}

- (void)testPriorityQueueSort
{
    NSString *s1 = @"abc";
    NSString *s2 = @"def";
    NSString *s3 = @"zyx";
    MJPriorityQueue *q = [MJPriorityQueue queue];
    [q push:s1];
    [q push:s3];
    [q push:s2];
    
    STAssertTrue([[q top] isEqual:s3], @"Queue sorting failed");
    [q pop];
    STAssertTrue([[q top] isEqual:s2], @"Queue sorting failed");
    [q pop];
    STAssertTrue([[q top] isEqual:s1], @"Queue sorting failed");
    [q pop];
}

//
//
//

#pragma mark PriorityDictionary

- (void)testPriorityDictionaryEmpty
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    STAssertTrue([q empty], @"Dictionary should be empty");
}

- (void)testPriorityDictionarySize
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    [q setObject:@1 forKey:@"key"];
    STAssertTrue([q size] == 1, @"Dictionary size should be 1");
}

- (void)testPriorityDictionaryPush
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    [q setObject:@1 forKey:@"key"];
    STAssertTrue([[q top] isEqual:@"key"], @"Dictionary top is wrong");
}

- (void)testPriorityDictionarySubscripting
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    q[@"key"] = @1;
    STAssertTrue([[q top] isEqual:@"key"], @"Dictionary top is wrong");
}

- (void)testPriorityDictionaryPopSize
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    q[@"key"] = @1;
    [q pop];
    STAssertTrue([q size] == 0, @"Dictionary size should be 0");
}

- (void)testPriorityDictionaryPopEmpty
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    q[@"key"] = @1;
    [q pop];
    STAssertTrue([q empty], @"Dictionary should be empty");
}

- (void)testPriorityDictionaryClear
{
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    q[@"key1"] = @1;
    q[@"key2"] = @1;
    [q clear];
    STAssertTrue([q empty], @"Dictionary should be empty");
}

- (void)testPriorityDictionarySort1
{
    NSString *k1 = @"k1";
    NSString *k2 = @"k2";
    NSString *k3 = @"k3";
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    q[k1] = @1;
    q[k2] = @2;
    q[k3] = @3;
    
    STAssertTrue([[q top] isEqual:k3], @"Dictionary sorting failed");
    [q pop];
    STAssertTrue([[q top] isEqual:k2], @"Dictionary sorting failed");
    [q pop];
    STAssertTrue([[q top] isEqual:k1], @"Dictionary sorting failed");
    [q pop];
}

- (void)testPriorityDictionarySort2
{
    NSString *k1 = @"k1";
    NSString *k2 = @"k2";
    NSString *k3 = @"k3";
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    q[k2] = @2;
    q[k1] = @1;

    STAssertTrue([[q top] isEqual:k2], @"Dictionary sorting failed");
    [q pop];

    q[k3] = @3;
    
    STAssertTrue([[q top] isEqual:k3], @"Dictionary sorting failed");
    
    [q removeObjectForKey:k3];
    
    STAssertTrue([[q top] isEqual:k1], @"Dictionary sorting failed");
    [q pop];
}

- (void)testPriorityDictionarySort3
{
    NSArray *keys = @[@"k1",@"k2",@"k3",@"k4",@"k5",@"k6",@"k12",@"k11",@"k10",@"k9",@"k8",@"k7"];
    NSArray *vals = @[@1,@2,@3,@4,@5,@6,@12,@11,@10,@9,@8,@7];
    NSArray *ordered = [vals sortedArrayUsingComparator:^(id o1, id o2){return [o2 compare:o1];}];
    
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    
    for (int i = 0; i < [keys count]; ++i)
    {
        q[keys[i]] = vals[i];
    }
    
    NSString *key;
    for (int i = 0; (key = [q top]); ++i)
    {
        STAssertTrue([q[key] isEqual:ordered[i]],
                     @"Dictionary sorting failed for {%@: %d}. Value should be %d",
                     key, [(NSNumber*)q[key] integerValue], [ordered[i] integerValue]);

        [q pop];
    }
}

- (void)testPriorityDictionarySort4
{
    NSArray *keys = @[@"k1",@"k2",@"k3",@"k4",@"k5",@"k6",@"k12",@"k11",@"k10",@"k9",@"k8",@"k7"];
    NSArray *vals = @[@1,@2,@3,@4,@5,@6,@12,@11,@10,@9,@8,@7];
    
    MJPriorityDictionary *q = [MJPriorityDictionary dictionary];
    
    for (int i = 0; i < [keys count]; ++i)
    {
        q[keys[i]] = vals[i];
    }
    
    int last = [keys count] - 3;
    for (int i = 0; i < last; ++i)
    {
        [q removeObjectForKey:keys[i]];
    }
    
    NSString *t = [q top];
    STAssertTrue([[q top] isEqual:keys[last]], @"Dictionary sorting failed");
    
    for (int i = 0; i < [keys count]; ++i)
    {
        q[keys[i]] = vals[i];
    }

    t = [q top];

    STAssertTrue([[q top] isEqual:@"k12"], @"Dictionary sorting failed");
    
}

#pragma mark Dijkstra

/*
 As an example of the input format, here is the graph from Cormen, Leiserson, and Rivest (Introduction to Algorithms, 1st edition), page 528:
 <pre> G = {'s':{'u':10, 'x':5}, 'u':{'v':1, 'x':2}, 'v':{'y':4}, 'x':{'u':3, 'v':9, 'y':2}, 'y':{'s':7, 'v':6}} </pre>
 The shortest path from s to v is ['s', 'x', 'u', 'v'] and has length 9.
 */
-(void)testShortestPath
{
    NSDictionary *G = @{@"s":@{@"u":@10, @"x":@5},
                        @"u":@{@"v":@1, @"x":@2},
                        @"v":@{@"y":@4},
                        @"x":@{@"u":@3, @"v":@9, @"y":@2},
                        @"y":@{@"s":@7, @"v":@6}};
    
    NSString *start = @"s";
    NSString *end = @"v";
    
    NSArray *answer = @[@"s", @"x", @"u", @"v"];
    NSArray *path = shortestPath(G, start, end);

    STAssertTrue([answer count] == [path count], @"Wrong length of the found path.");

    if ([answer count] != [path count])
        return;
    
    for (int i = 0; i < [answer count]; ++i)
    {
        STAssertTrue(answer[i] == path[i], @"Wrong vertex in the found path.");
    }
}

-(void)testDijkstra
{
    NSDictionary *G = @{@"s":@{@"u":@10, @"x":@5},
                        @"u":@{@"v":@1, @"x":@2},
                        @"v":@{@"y":@4},
                        @"x":@{@"u":@3, @"v":@9, @"y":@2},
                        @"y":@{@"s":@7, @"v":@6}};
    
    NSString *start = @"s";
    NSString *end = @"v";
    
    //NSArray *answer = @[@"s", @"x", @"u", @"v"];
    MJDijkstraSolution res = Dijkstra(G, start, end);
    
    STAssertTrue([res.distances[end] integerValue] == 9, @"Wrong length of a found path.");
}

-(void)testDijkstraSameLength
{
    NSDictionary *G = @{@"s":@{@"u":@1, @"x":@1},
                        @"u":@{@"v":@1, @"x":@1},
                        @"v":@{@"y":@1},
                        @"x":@{@"u":@1, @"v":@1, @"y":@1},
                        @"y":@{@"s":@1, @"v":@1}};
    
    NSString *start = @"s";
    NSString *end = @"v";
    
    //NSArray *answer = @[@"s", @"x", @"u", @"v"];
    MJDijkstraSolution res = Dijkstra(G, start, end);
    NSArray *path = shortestPath(G, start, end);

    for (NSString *v in path)
        NSLog(@"Vertex %@", v);
    
    NSLog(@"Path length: %d", [res.distances[end] integerValue]);
    //STAssertTrue([res.distances[end] integerValue] == 9, @"Wrong length of a found path.");
}

-(void)testDijkstraWithNodes
{
    // equivalent testDijkstra
    NSMutableDictionary *graph = [@{} mutableCopy]; {
        for (NSString *unique in @[@"s", @"u", @"v", @"x", @"y"]) {
            graph[unique] = [[DijkstraNodeTestImpl alloc] initWithUnique:unique];
        }
        
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"s"] toNode:graph[@"u"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"s"] toNode:graph[@"x"] length:@5];

        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"u"] toNode:graph[@"v"] length:@1];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"u"] toNode:graph[@"x"] length:@2];

        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"v"] toNode:graph[@"y"] length:@1];

        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"x"] toNode:graph[@"u"] length:@3];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"x"] toNode:graph[@"v"] length:@9];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"x"] toNode:graph[@"y"] length:@2];

        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"y"] toNode:graph[@"s"] length:@7];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"y"] toNode:graph[@"v"] length:@6];

//        NSLog(@"%@", graph);
    }

    DijkstraNodeTestImpl *start = graph[@"s"];
    DijkstraNodeTestImpl *end = graph[@"v"];
    
    //NSArray *answer = @[@"s", @"x", @"u", @"v"];
    MJDijkstraSolution res = DijkstraWithNodes(start, end);
    
    STAssertTrue([res.distances[end] integerValue] == 9, @"Wrong length of a found path.");
}

-(void)testShortestPathWithNodes
{
    // equivalent testShortestPath
    NSMutableDictionary *graph = [@{} mutableCopy]; {
        for (NSString *unique in @[@"s", @"u", @"v", @"x", @"y"]) {
            graph[unique] = [[DijkstraNodeTestImpl alloc] initWithUnique:unique];
        }
        
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"s"] toNode:graph[@"u"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"s"] toNode:graph[@"x"] length:@5];
        
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"u"] toNode:graph[@"v"] length:@1];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"u"] toNode:graph[@"x"] length:@2];
        
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"v"] toNode:graph[@"y"] length:@1];
        
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"x"] toNode:graph[@"u"] length:@3];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"x"] toNode:graph[@"v"] length:@9];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"x"] toNode:graph[@"y"] length:@2];
        
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"y"] toNode:graph[@"s"] length:@7];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"y"] toNode:graph[@"v"] length:@6];
        
//        NSLog(@"%@", graph);
    }
    
    DijkstraNodeTestImpl *start = graph[@"s"];
    DijkstraNodeTestImpl *end = graph[@"v"];
        
    NSArray *answer = @[graph[@"s"], graph[@"x"], graph[@"u"], graph[@"v"]];
    NSArray *path = shortestPathWithNodes(start, end);
    
    STAssertTrue([answer count] == [path count], @"Wrong length of the found path.");
    
    if ([answer count] != [path count])
        return;
    
    for (int i = 0; i < [answer count]; ++i)
    {
        STAssertTrue(answer[i] == path[i], @"Wrong vertex in the found path.");
    }
}

-(void)testShortestPathWithCirculaNodes
{
    // shortestPath with circle
    //       {1} - 10 - 9 - 8
    //        |             |
    //        2             |
    //        |             |
    //  a - [b,3] ------- [c,7] - d - e
    //        |             |
    //        4 ---- 5 --- {6}
    // 1 ==> 6 : 1-2-3-d-7-6
    NSMutableDictionary *graph = [@{} mutableCopy]; {
        for (NSString *unique in @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"]) {
            graph[unique] = [[DijkstraNodeTestImpl alloc] initWithUnique:unique];
        }
        for (NSString *unique in @[@"a", @"b", @"c", @"d", @"e"]) {
            graph[unique] = [[DijkstraNodeTestImpl alloc] initWithUnique:unique];
        }
        
        // circle
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"1"] toNode:graph[@"2"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"2"] toNode:graph[@"3"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"3"] toNode:graph[@"4"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"4"] toNode:graph[@"5"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"5"] toNode:graph[@"6"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"6"] toNode:graph[@"7"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"7"] toNode:graph[@"8"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"8"] toNode:graph[@"9"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"9"] toNode:graph[@"10"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"10"] toNode:graph[@"1"] length:@10];
        
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"2"] toNode:graph[@"1"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"3"] toNode:graph[@"2"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"4"] toNode:graph[@"3"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"5"] toNode:graph[@"4"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"6"] toNode:graph[@"5"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"7"] toNode:graph[@"6"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"8"] toNode:graph[@"7"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"9"] toNode:graph[@"8"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"10"] toNode:graph[@"9"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"1"] toNode:graph[@"10"] length:@10];

        // arrow
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"a"] toNode:graph[@"b"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"b"] toNode:graph[@"c"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"c"] toNode:graph[@"d"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"d"] toNode:graph[@"e"] length:@10];
        
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"b"] toNode:graph[@"a"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"c"] toNode:graph[@"b"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"d"] toNode:graph[@"c"] length:@10];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"e"] toNode:graph[@"d"] length:@10];
        
        // edge of arrow
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"b"] toNode:graph[@"3"] length:@1];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"c"] toNode:graph[@"7"] length:@1];

        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"3"] toNode:graph[@"b"] length:@1];
        [DijkstraEdgeTestImpl setEdgeWithFromNode:graph[@"7"] toNode:graph[@"c"] length:@1];
//        NSLog(@"%@", graph);
    }
    
    DijkstraNodeTestImpl *start = graph[@"1"];
    DijkstraNodeTestImpl *end = graph[@"6"];
    
    NSArray *answer = @[graph[@"1"], graph[@"2"], graph[@"3"], graph[@"b"], graph[@"c"], graph[@"7"], graph[@"6"]];
    NSArray *path = shortestPathWithNodes(start, end);
    
    STAssertTrue([answer count] == [path count], @"Wrong length of the found path.");
    
    if ([answer count] != [path count])
        return;
    
    for (int i = 0; i < [answer count]; ++i)
    {
        STAssertTrue(answer[i] == path[i], @"Wrong vertex in the found path.");
    }
}

@end
