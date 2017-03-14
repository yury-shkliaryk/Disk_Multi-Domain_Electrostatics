Include "disk2domains.dat";

Group
{
    Omega1 = Region[{DOMAIN1, INFY1, INFX1}];
    Omega2 = Region[{DOMAIN2, INFY2, INFX2}]; 
    Omega = Region[{Omega1, Omega2}];
    GamaDirichlet1 = Region[{DISK}];
    GamaDirichlet2 = Region[{BNDINF}];
    GamaNeumann = Region[{AXISY}];
    InfX = Region[{INFX1, INFX2}];
    InfY = Region[{INFY1, INFY2}];
    OmegaTotal = Region[{Omega,GamaDirichlet1,GamaDirichlet2,GamaNeumann}];
}

Jacobian {
  { Name JVol ;
    Case {
      { Region InfX; Jacobian VolAxiRectShell {x_max-x_width, x_max, 1};}
      { Region InfY; Jacobian VolAxiRectShell {y_max-y_width, y_max, 2};}
      { Region All ; Jacobian VolAxi ; }
    }
  }
}

Integration {
  { Name I1 ;
    Case {
      { Type Gauss ;
        Case {
	  { GeoElement Point       ; NumberOfPoints  1 ; }
	  { GeoElement Line        ; NumberOfPoints  3 ; }
	  { GeoElement Triangle    ; NumberOfPoints  4 ; }
	  { GeoElement Quadrangle  ; NumberOfPoints  4 ; }
	  { GeoElement Tetrahedron ; NumberOfPoints  4 ; }
	  { GeoElement Hexahedron  ; NumberOfPoints  6 ; }
	  { GeoElement Prism       ; NumberOfPoints  6 ; }
	}
      }
    }
  }
}

Constraint
{
    {Name DirichletBC; Type Assign;
	    Case
	    {
		{Region GamaDirichlet1; Value phi;}
		{Region GamaDirichlet2; Value 0;}
	    }
    }
}

FunctionSpace
{
    {
        Name Vh; Type Form0;
        BasisFunction
        {
        {Name wn; NameOfCoef vn; Function BF_Node;
         Support OmegaTotal; Entity NodesOf[All];}
        }
        Constraint{
        {
         NameOfCoef vn; EntityType NodesOf;
         NameOfConstraint DirichletBC;
        }
        }
    }
}

Function
{
    eps[Omega1] = eps1;
    eps[Omega2] = eps2;
}

Formulation
{
    {
        Name DiskPotential; Type FemEquation;
        Quantity
        {
            {Name u; Type Local; NameOfSpace Vh;}
        }
        Equation
        {
            Galerkin{ [eps[]*Dof{Grad u}, {Grad u}]; In Omega; Jacobian JVol; Integration I1;}
        }
    }
}

Resolution
{
    {
        Name DiskPotential;
        System
        {
            {Name Syst; NameOfFormulation DiskPotential;}
        }
        Operation
        {
            Generate[Syst]; Solve[Syst]; SaveSolution[Syst];
        }
    }
}

PostProcessing{
  {Name DiskPotential; NameOfFormulation DiskPotential;
    Quantity{
      {Name u; Value {Local{[{u}]; In Omega; Jacobian JVol;}}}
    }
  }
}

PostOperation{
  {Name Map_u; NameOfPostProcessing DiskPotential;
    Operation{
      Print[u, OnElementsOf Omega, File "u.pos"];
    }
  }
}

