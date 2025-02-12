@testset "Refinement" begin
  @testset "TriRefinement" begin
    grid = CartesianGrid{T}(3, 3)
    ref1 = refine(grid, TriRefinement())
    ref2 = refine(ref1, TriRefinement())

    if visualtests
      fig = Mke.Figure(resolution=(900, 300))
      viz(fig[1,1], grid, showfacets=true)
      viz(fig[1,2], ref1, showfacets=true)
      viz(fig[1,3], ref2, showfacets=true)
      @test_reference "data/trirefine-$T.png" fig
    end
  end

  @testset "QuadRefinement" begin
    points = P2[(0,0), (1,0), (0,1), (1,1), (0.25,0.25), (0.75,0.25), (0.5,0.75)]
    connec = connect.([(1,2,6,5),(1,5,7,3),(2,4,7,6),(3,7,4)])
    mesh   = SimpleMesh(points, connec)
    ref1   = refine(mesh, QuadRefinement())
    ref2   = refine(ref1, QuadRefinement())
    ref3   = refine(ref2, QuadRefinement())

    if visualtests
      fig = Mke.Figure(resolution=(900, 300))
      viz(fig[1,1], ref1, showfacets=true)
      viz(fig[1,2], ref2, showfacets=true)
      viz(fig[1,3], ref3, showfacets=true)
      @test_reference "data/quadrefine-$T.png" fig
    end
  end

  @testset "CatmullClark" begin
    points = P2[(0,0), (1,0), (0,1), (1,1), (0.5,0.5)]
    connec = connect.([(1,2,5),(2,4,5),(4,3,5),(3,1,5)])
    mesh   = SimpleMesh(points, connec)
    ref1   = refine(mesh, CatmullClark())
    ref2   = refine(ref1, CatmullClark())
    ref3   = refine(ref2, CatmullClark())

    if visualtests
      fig = Mke.Figure(resolution=(900, 300))
      viz(fig[1,1], ref1, showfacets=true)
      viz(fig[1,2], ref2, showfacets=true)
      viz(fig[1,3], ref3, showfacets=true)
      @test_reference "data/catmullclark-1-$T.png" fig
    end

    points = P2[(0,0), (1,0), (0,1), (1,1), (0.25,0.25), (0.75,0.25), (0.5,0.75)]
    connec = connect.([(1,2,6,5),(1,5,7,3),(2,4,7,6),(3,7,4)])
    mesh   = SimpleMesh(points, connec)
    ref1   = refine(mesh, CatmullClark())
    ref2   = refine(ref1, CatmullClark())
    ref3   = refine(ref2, CatmullClark())

    if visualtests
      fig = Mke.Figure(resolution=(900, 300))
      viz(fig[1,1], ref1, showfacets=true)
      viz(fig[1,2], ref2, showfacets=true)
      viz(fig[1,3], ref3, showfacets=true)
      @test_reference "data/catmullclark-2-$T.png" fig
    end

    points = P3[(0,0,0),(1,0,0),(1,1,0),(0,1,0),(0,0,1),(1,0,1),(1,1,1),(0,1,1)]
    connec = connect.([(1,4,3,2),(5,6,7,8),(1,2,6,5),(3,4,8,7),(1,5,8,4),(2,3,7,6)])
    mesh   = SimpleMesh(points, connec)
    ref1   = refine(mesh, CatmullClark())
    ref2   = refine(ref1, CatmullClark())
    ref3   = refine(ref2, CatmullClark())

    if visualtests
      fig = Mke.Figure(resolution=(900, 300))
      viz(fig[1,1], ref1, showfacets=true)
      viz(fig[1,2], ref2, showfacets=true)
      viz(fig[1,3], ref3, showfacets=true)
      @test_reference "data/catmullclark-3-$T.png" fig
    end
  end
end
