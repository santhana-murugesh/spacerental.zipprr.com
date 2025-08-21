import React, { useState } from 'react'
import { DashboardLayout } from './DashboardLayout'
import { useAuth } from './AuthContext'

export const ChangePassword = () => {
	const { user, authLoading, token } = useAuth()
	const [form, setForm] = useState({
		current_password: '',
		new_password: '',
		new_password_confirmation: ''
	})
	const [submitting, setSubmitting] = useState(false)
	const [notice, setNotice] = useState(null)
	const [error, setError] = useState(null)

	const API_BASE_URL =
		window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
			? import.meta.env.VITE_API_BASE_URL_LOCAL
			: import.meta.env.VITE_API_BASE_URL

	const handleChange = (e) => {
		const { name, value } = e.target
		setForm((prev) => ({ ...prev, [name]: value }))
	}

	const submitViaApi = async () => {
		const res = await fetch(`${API_BASE_URL}/api/user/update-password`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json',
				Authorization: `Bearer ${token}`
			},
			body: JSON.stringify(form)
		})
		if (res.status === 422) {
			const data = await res.json()
			const first = data?.errors ? Object.values(data.errors)[0]?.[0] : null
			throw new Error(first || 'Validation failed')
		}
		if (!res.ok) throw new Error('Failed to change password')
	}

	const submitViaWeb = async () => {
		const csrfRes = await fetch('/csrf-token', { credentials: 'same-origin' })
		const csrf = await csrfRes.json()
		const body = new URLSearchParams()
		Object.entries(form).forEach(([k, v]) => body.append(k, v ?? ''))
		const res = await fetch('/user/update-password', {
			method: 'POST',
			credentials: 'same-origin',
			headers: { 'X-CSRF-TOKEN': csrf.token, Accept: 'application/json', 'X-Requested-With': 'XMLHttpRequest', 'Content-Type': 'application/x-www-form-urlencoded' },
			body
		})
		if (res.status === 422) {
			const data = await res.json()
			const first = data?.errors ? Object.values(data.errors)[0]?.[0] : null
			throw new Error(first || 'Validation failed')
		}
		if (!(res.ok || res.status === 302)) throw new Error('Failed to change password')
	}

	const handleSubmit = async (e) => {
		e.preventDefault()
		setSubmitting(true)
		setError(null)
		setNotice(null)
		try {
			if (token) {
				await submitViaApi()
			} else {
				await submitViaWeb()
			}
			setForm({ current_password: '', new_password: '', new_password_confirmation: '' })
			setNotice('Password updated successfully.')
		} catch (err) {
			setError(err.message || 'Failed to change password')
		} finally {
			setSubmitting(false)
		}
	}

	if (authLoading) {
		return <div className="flex justify-center items-center min-h-screen">Loading...</div>
	}

	if (!user) {
		return <div className="flex justify-center items-center min-h-screen">Please log in to continue.</div>
	}

	return (
		<DashboardLayout title="Change Password">
			<div className="bg-white rounded-lg shadow-sm p-6 max-w-3xl">
				{notice && (
					<div className="mb-4 rounded-md bg-green-50 border border-green-200 p-3 text-green-800 text-sm">{notice}</div>
				)}
				{error && (
					<div className="mb-4 rounded-md bg-red-50 border border-red-200 p-3 text-red-800 text-sm">{error}</div>
				)}
				<form onSubmit={handleSubmit} className="space-y-4">
					<div>
						<label className="block text-sm font-medium text-gray-700">Current Password</label>
						<input type="password" name="current_password" value={form.current_password} onChange={handleChange} required className="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
					</div>
					<div>
						<label className="block text-sm font-medium text-gray-700">New Password</label>
						<input type="password" name="new_password" value={form.new_password} onChange={handleChange} required className="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
					</div>
					<div>
						<label className="block text-sm font-medium text-gray-700">Confirm Password</label>
						<input type="password" name="new_password_confirmation" value={form.new_password_confirmation} onChange={handleChange} required className="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
					</div>
					<div className="pt-2">
						<button type="submit" disabled={submitting} className="px-4 py-2 rounded-md text-white bg-blue-600 hover:bg-blue-700 disabled:opacity-50">
							{submitting ? 'Saving...' : 'Submit'}
						</button>
					</div>
				</form>
			</div>
		</DashboardLayout>
	)
}
