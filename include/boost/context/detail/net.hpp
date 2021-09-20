
//          Copyright Casey Brodley 2019.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

#ifndef BOOST_CONTEXT_DETAIL_NET_H
#define BOOST_CONTEXT_DETAIL_NET_H

#include <boost/asio/associated_allocator.hpp>
#include <boost/asio/associated_executor.hpp>
#include <boost/asio/async_result.hpp>
#include <boost/asio/bind_executor.hpp>
#include <boost/asio/executor.hpp>
#include <boost/asio/is_executor.hpp>
#include <boost/asio/strand.hpp>

#define CONTEXT_NET_NAMESPACE boost::asio

namespace boost {
namespace context {
namespace detail {
namespace net {

using boost::asio::associated_executor_t;
using boost::asio::get_associated_executor;

using boost::asio::associated_allocator_t;
using boost::asio::get_associated_allocator;

using boost::asio::execution_context;
using boost::asio::executor;
using boost::asio::executor_binder;
using boost::asio::is_executor;

using boost::asio::strand;

}}}}

#endif // BOOST_CONTEXT_DETAIL_NET_H
