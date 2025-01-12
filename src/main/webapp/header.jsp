<!-- header.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header class="bg-gradient-to-r from-blue-600 to-blue-800 shadow-lg">
    <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
            <div class="flex items-center">
                <a href="appreciations" class="text-white text-xl font-bold">📖 Livre d'Or</a>
                <div class="hidden md:block ml-10">
                    <div class="flex items-baseline space-x-4">
                        <a href="appreciations" class="text-white hover:bg-blue-700 px-3 py-2 rounded-md">
                            Appréciations
                        </a>
                        <a href="index.jsp" class="text-blue-200 hover:bg-blue-700 px-3 py-2 rounded-md">
                            Nouvelle appréciation
                        </a>
                    </div>
                </div>
            </div>
            <div class="flex items-center">
                <span class="text-white text-sm">
                    <i class="fas fa-user mr-2"></i>
                    Welcome
                </span>
            </div>
        </div>
    </nav>
</header>