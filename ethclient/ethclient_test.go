// Copyright 2016 The go-ballstest Authors
// This file is part of the go-ballstest library.
//
// The go-ballstest library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The go-ballstest library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the go-ballstest library. If not, see <http://www.gnu.org/licenses/>.

package ethclient

import "github.com/ballstest/go-ballstest"

// Verify that Client implements the ballstest interfaces.
var (
	_ = ballstest.ChainReader(&Client{})
	_ = ballstest.TransactionReader(&Client{})
	_ = ballstest.ChainStateReader(&Client{})
	_ = ballstest.ChainSyncReader(&Client{})
	_ = ballstest.ContractCaller(&Client{})
	_ = ballstest.GasEstimator(&Client{})
	_ = ballstest.GasPricer(&Client{})
	_ = ballstest.LogFilterer(&Client{})
	_ = ballstest.PendingStateReader(&Client{})
	// _ = ballstest.PendingStateEventer(&Client{})
	_ = ballstest.PendingContractCaller(&Client{})
)
