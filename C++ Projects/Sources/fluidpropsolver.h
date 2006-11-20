/* *****************************************************************
 * Interface of class FluidPropSolver
 *
 * This class defines a solver object encapsulating a FluidProp object
 *
 * The class will work if FluidProp is correctly installed, and if
 * the following files, defining the CFluidProp object, are included 
 * in the C project:
 *   - FluidProp_IF.h
 *   - FluidProp_IF.cpp
 *   - FluidProp_COM.h
 *
 * Currently, only Microsoft Visual Studio .NET (2002) is supported.
 * It should be used both to compile the ExternalTwoPhaseMedium.lib
 * library, and to compile the dymosim.exe Dymola executable.
 *
 * To instatiate a specific FluidProp fluid, it is necessary to set 
 * the libraryName and substanceNames package constants as in the
 * following example:
 *
 * libraryName = "FluidProp.RefProp";
 * substanceNames = {"H2O"};
 *
 * Instead of RefProp, it is possible to indicate TPSI, StanMix, etc.
 * Instead of H2O, it is possible to indicate any supported substance
 *
 * See also the solvermap.cpp code
 *
 * Francesco Casella, Christoph Richter, Oct 2006
 ********************************************************************/

#ifndef FLUIDPROPSOLVER_H_
#define FLUIDPROPSOLVER_H_

#include "basesolver.h"

#ifdef FLUIDPROP

#include "FluidProp_IF.h"

class FluidPropSolver : public BaseSolver{
public:
	FluidPropSolver(const string &mediumName, const string &libraryName, const string &substanceName);
	~FluidPropSolver();
	virtual void setMediumConstants(TwoPhaseMediumProperties *const properties);

	virtual void setSat_p(const double &p, TwoPhaseMediumProperties *const properties);
	virtual void setSat_T(const double &T, TwoPhaseMediumProperties *const properties);

	virtual void setState_dT(const double &d, const double &T, const int &phase, TwoPhaseMediumProperties *const properties);
	virtual void setState_ph(const double &p, const double &h, const int &phase, TwoPhaseMediumProperties *const properties);
	virtual void setState_ps(const double &p, const double &s, const int &phase, TwoPhaseMediumProperties *const properties);
	virtual void setState_pT(const double &p, const double &T, TwoPhaseMediumProperties *const properties);

protected:
    CFluidProp FluidProp;  // Instance of FluidProp wrapper object
};

#endif // FLUIDPROP

#endif /*FLUIDPROPSOLVER_H_*/